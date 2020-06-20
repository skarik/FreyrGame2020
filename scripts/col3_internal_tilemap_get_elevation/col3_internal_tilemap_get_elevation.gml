/// @desc DO_NOT_CALL
/// This function should not be called directly.
#macro kElevationInvalid -9999

var check_x = argument0;
var check_y = argument1;

var cel_x = floor(check_x / 16);
var cel_y = floor(check_y / 16);

var tile_elevation = kElevationInvalid;

col3_internal_query_collision_maps();
var layer_count = array_length_1d(global.collidable_layers);
for (var i = 0; i < layer_count; ++i)
{
	var tilemap = global.collidable_layers[i];
	var tile = tilemap_get(tilemap, cel_x, cel_y);
	var tile_id = tile & 0xFF;

	if (tile_id >= 16 && tile_id < 32)
	{
		tile_elevation = (tile_id - 16) * 16;
		break;
	}
	else if (tile_id >= 48 && tile_id < 64)
	{
		tile_elevation = (tile_id - 48) * -16;
		break;
	}
}

return tile_elevation;