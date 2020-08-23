///@function procGenDesertRemoveRoom(Room)
///@param Room

var roomObject = argument0;

var roomLayers = roomObject[kiProcLayers];
var roomInstances = roomObject[kiProcInstances];
var roomCollisionLayers = roomObject[kiProcCollisionMaps];

debugOut("Destroying a room...");

for (var i = 0; i < array_length_1d(roomLayers); ++i)
{
	var tilemap = layer_tilemap_get_id(roomLayers[i]);
	/*if (layer_tilemap_exists(roomLayers[i], tilemap))
	{
		var tileset = tilemap_get_tileset(tilemap);
		if (tileset == tilesetCollision)
		{
			global.collidable_layers = array_remove_value(global.collidable_layers, tilemap);
		}
	}*/
	layer_destroy(roomLayers[i]);
}

for (var i = 0; i < array_length_1d(roomCollisionLayers); ++i)
{
	var index = array_get_index(global.collidable_layers, roomCollisionLayers[i]);
	global.collidable_layers = array_remove_index(global.collidable_layers, index);
	global.collidable_offset_x = array_remove_index(global.collidable_offset_x, index);
	global.collidable_offset_y = array_remove_index(global.collidable_offset_y, index);
}

for (var i = 0; i < array_length_1d(roomInstances); ++i)
{
	var instance = roomInstances[i];
	idelete(instance);
}