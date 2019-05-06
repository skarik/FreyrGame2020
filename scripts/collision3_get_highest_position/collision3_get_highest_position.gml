/// @description collision3_get_highest_position(x, y, z)
/// @param x
/// @param y
/// @param z

var check_x = argument0;
var check_y = argument1;
var check_z = argument2;

// Check for all transition zones at the given area
var max_z = -1024;
var results = ds_list_create();
var results_num = collision_point_list(check_x, check_y, ob_elevationArea, false, true, results, false);
for (var i = 0; i < results_num; ++i)
{
	var area_z = results[|i].z;
	max_z = max(max_z, area_z);
}
ds_list_destroy(results);

if (results_num == 0)
{
	return check_z;
}
else
{
	return max_z;
}