/// @desc DO_NOT_CALL
/// This function should not be called directly.
var check_x = argument0;
var check_y = argument1;

var cel_x = floor(check_x / 16);
var cel_y = floor(check_y / 16);

col3_internal_query_collision_maps();
var layer_count = array_length_1d(global.water_layers);
for (var i = 0; i < layer_count; ++i)
{
	var tilemap = global.water_layers[i];
	var tile = tilemap_get(tilemap, cel_x, cel_y);
	var tile_id = tile & 0xFF;

	if (tile_id != 0)
		return true;
}
return false;