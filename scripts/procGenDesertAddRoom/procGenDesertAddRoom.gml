var positionNewRoom = argument0;
var iRoomIndex = argument1;

var nextRoom = possibleRooms[iRoomIndex];
var nextBbox = possibleRoomBbox[iRoomIndex];

debugOut("Creating new room at " + string(positionNewRoom[0]) + "," + string(positionNewRoom[1]));

// Set up new bounding box
nextBbox = abbox_create(positionNewRoom[0], positionNewRoom[1], nextBbox[2], nextBbox[3]);

// Copy the layers and send them over
var nextLayers = [];
var nextCollisionMaps = [];
var nextInstances = [];

layer_set_target_room(nextRoom);
var all_layers = layer_get_all();
var layer_count = array_length_1d(all_layers);
for (var i = 0; i < layer_count; ++i)
{
	var currentLayer = all_layers[i];
	var layerName = layer_get_name(currentLayer);
	
	var tilemap = layer_tilemap_get_id(currentLayer);
	if (layer_tilemap_exists(currentLayer, tilemap))
	{
		var layerDepth = layer_get_depth(currentLayer);
		var layerTileset = tilemap_get_tileset(tilemap);
		var layerCelWidth = tilemap_get_width(tilemap);
		var layerCelHeight = tilemap_get_height(tilemap);
		
		// Create tilemap in new room
		layer_reset_target_room();
		var nextLayer = layer_create(layerDepth);
		var nextTilemap = layer_tilemap_create(nextLayer, positionNewRoom[0], positionNewRoom[1], layerTileset, layerCelWidth, layerCelHeight);
		
		// Copy it manually
		for (var ix = 0; ix < layerCelWidth; ++ix)
		{
			for (var iy = 0; iy < layerCelHeight; ++iy)
			{
				layer_set_target_room(nextRoom);
				var tile = tilemap_get(tilemap, ix, iy);
				layer_reset_target_room();
				tilemap_set(nextTilemap, tile, ix, iy);
			}
		}
		
		// Save the layer
		nextLayers[array_length_1d(nextLayers)] = nextLayer;
		
		// Update tileset based on properties
		layer_reset_target_room();
		if (layerTileset == tilesetCollision)
		{
			nextCollisionMaps[array_length_1d(nextCollisionMaps)] = nextTilemap;
			global.collidable_layers[array_length_1d(global.collidable_layers)] = nextTilemap;
			global.collidable_offset_x[array_length_1d(global.collidable_offset_x)] = -floor(positionNewRoom[0] / 16);
			global.collidable_offset_y[array_length_1d(global.collidable_offset_y)] = -floor(positionNewRoom[1] / 16);
			layer_set_visible(nextLayer, false);
		}
		
		// Go back to room-copy mode
		layer_set_target_room(nextRoom);
	}
	else
	{
		var layerDepth = layer_get_depth(currentLayer);
		var layerElements = layer_get_all_elements(currentLayer);
		var layerElementCount = array_length_1d(layerElements);
		
		// Create new layer, and duplicate all the sprite assets
		layer_reset_target_room();
		var nextLayer = layer_create(layerDepth, layerName);
		layer_set_target_room(nextRoom);
		
		for (var iElement = 0; iElement < layerElementCount; ++iElement)
		{
			var element = layerElements[iElement];
			
			var elementType = layer_get_element_type(element);
			if (elementType == layerelementtype_sprite)
			{
				var spriteSprite = layer_sprite_get_sprite(element);
				var spriteIndex = layer_sprite_get_index(element);
				var spriteX = layer_sprite_get_x(element);
				var spriteY = layer_sprite_get_y(element);
				var spriteXScale = layer_sprite_get_xscale(element);
				var spriteYScale = layer_sprite_get_yscale(element);
				var spriteAngle = layer_sprite_get_angle(element);
				var spriteBlend = layer_sprite_get_blend(element);
				var spriteAlpha = layer_sprite_get_alpha(element);
				var spriteSpeed = layer_sprite_get_speed(element);
				
				if (spriteSprite != sc_32x32c_blond)
				{
					layer_reset_target_room();
					
					var nextSprite = layer_sprite_create(nextLayer,
						spriteX + positionNewRoom[0],
						spriteY + positionNewRoom[1],
						spriteSprite);
					layer_sprite_index(nextSprite, spriteIndex);
					layer_sprite_speed(nextSprite, spriteSpeed);
					layer_sprite_xscale(nextSprite, spriteXScale);
					layer_sprite_yscale(nextSprite, spriteYScale);
					layer_sprite_angle(nextSprite, spriteAngle);
					layer_sprite_blend(nextSprite, spriteBlend);
					layer_sprite_alpha(nextSprite, spriteAlpha);
					
					layer_set_target_room(nextRoom);
				}
			}
		}
		
		// Depending on the layer name, we may need to do unique startup
		if (string_pos("doodad", layerName) != 0)
		{
			// Go back to current room
			layer_reset_target_room();
			
			// Create doodads on current layer
			var listing = doodadInitOnLayer(nextLayer, string_pos("shadow", layerName) != 0, true);
			for (var iinst = 0; iinst < array_length_1d(listing); ++iinst)
			{
				nextInstances[array_length_1d(nextInstances)] = listing[iinst];
			}
			
			// Go back to room-copy mode
			layer_set_target_room(nextRoom);
		}
		else
		{
			// Save the layer
			nextLayers[array_length_1d(nextLayers)] = nextLayer;
		}
	}
}
layer_reset_target_room();


// Save new room info
var new_room = [nextRoom,
				nextBbox,
				false,
				nextLayers,
				nextInstances,
				iRoomIndex,
				nextCollisionMaps];
ds_list_add(allRooms, new_room);