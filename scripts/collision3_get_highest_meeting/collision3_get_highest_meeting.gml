/// @description collision3_get_highest_meeting(x, y, z)
/// @param x
/// @param y
/// @param z

var check_x = argument0;
var check_y = argument1;
var check_z = argument2;

var x1 = check_x - sprite_get_xoffset(mask_index) + sprite_get_bbox_left(mask_index);
var x2 = check_x - sprite_get_xoffset(mask_index) + sprite_get_bbox_right(mask_index);
var y1 = check_y - sprite_get_yoffset(mask_index) + sprite_get_bbox_top(mask_index);
var y2 = check_y - sprite_get_yoffset(mask_index) + sprite_get_bbox_bottom(mask_index);

// The following check relies on the invalid elevation being very negative
var tile_elevation = max(
	col3_internal_tilemap_get_elevation(x1, y1),
	col3_internal_tilemap_get_elevation(x2, y1),
	col3_internal_tilemap_get_elevation(x1, y2),
	col3_internal_tilemap_get_elevation(x2, y2));

// Check for all transition zones at the given area
var max_z = tile_elevation;
var results = ds_list_create();
var results_num = collision_rectangle_list(x1, y1, x2, y2, ob_elevationArea, false, true, results, false);
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