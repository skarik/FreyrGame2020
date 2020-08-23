/// @desc DO_NOT_CALL
/// This function should not be called directly.
#macro kElevationInvalid -9999

var check_x = argument0;
var check_y = argument1;

var cel_x = int64(check_x) >> 4;
var cel_y = int64(check_y) >> 4;

var tile_elevation = kElevationInvalid;

col3_internal_query_collision_maps();
var layer_count = array_length_1d(global.collidable_layers);
for (var i = 0; i < layer_count; ++i)
{
	var tilemap = global.collidable_layers[i];
	var tile = tilemap_get(tilemap, cel_x + global.collidable_offset_x[i], cel_y + global.collidable_offset_y[i]);
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