var check_x = argument0;
var check_y = argument1;

var cel_x = floor(check_x / 16);
var cel_y = floor(check_y / 16);

col3_internal_query_collision_maps();
for (var i = 0; i < array_length_1d(global.water_layers); ++i)
{
	var tilemap = global.water_layers[i];
	var tile = tilemap_get(tilemap, cel_x, cel_y);
	var tile_id = tile & 0xFF;

	if (tile_id != 0)
		return global.water_zposition[i];
}
return kElevationInvalid;