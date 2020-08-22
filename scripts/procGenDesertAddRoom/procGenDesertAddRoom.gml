var positionNewRoom = argument0;
var iRoomIndex = argument1;

var nextRoom = possibleRooms[iRoomIndex];
var nextBbox = possibleRoomBbox[iRoomIndex];

debugOut("Creating new room at " + string(positionNewRoom[0]) + "," + string(positionNewRoom[1]));

// Set up new bounding box
nextBbox = abbox_create(positionNewRoom[0], positionNewRoom[1], nextBbox[2], nextBbox[3]);

// Copy the layers and send them over
var nextLayers = [];

layer_set_target_room(nextRoom);
var all_layers = layer_get_all();
var layer_count = array_length_1d(all_layers);
for (var i = 0; i < layer_count; ++i)
{
	var currentLayer = all_layers[i];
	
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
		
		layer_set_target_room(nextRoom);
	}
	else
	{
		var layerName = layer_get_name(currentLayer);
		// Depending on the layer name, we may need to do unique startup
		
		var elements = layer_get_all_elements(currentLayer);
		
		for (var iElement = 0; iElement < array_length_1d(elements); ++iElement)
		{
			var element = elements[iElement];
			var elementType = layer_get_element_type(element);
			if (elementType == layerelementtype_sprite)
			{
				
			}
		}
	}
}
layer_reset_target_room();


// Save new room info
var new_room = [nextRoom,
				nextBbox,
				false,
				nextLayers,
				[]];
ds_list_add(allRooms, new_room);