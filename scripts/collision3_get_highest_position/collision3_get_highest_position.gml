/// @description collision3_get_highest_position(x, y, z)
/// @param x
/// @param y
/// @param z

var check_x = argument0;
var check_y = argument1;
var check_z = argument2;

// Check for all collision tilesets at the given position
var tile_elevation = col3_internal_tilemap_get_elevation(check_x, check_y);

// Check for all elevation zones at the given area
var max_z = tile_elevation;
var results = ds_list_create();
var results_num = collision_point_list(check_x, check_y, ob_elevationArea, false, true, results, false);
for (var i = 0; i < results_num; ++i)
{
	var area_z = results[|i].z;
	if (results[|i].ignore_below && check_z < area_z - 6)
		continue;
	max_z = max(max_z, area_z);
}
ds_list_destroy(results);

if (results_num == 0 && tile_elevation == kElevationInvalid)
{
	return check_z;
}
else
{
	return max_z;
}