/// @description collision3_meeting(x, y, z, less_than_only)
/// @param x
/// @param y
/// @param z
/// @param less_than_only

var check_x = argument0;
var check_y = argument1;
var check_z = argument2;
var falling = argument3;

var x1 = check_x - sprite_get_xoffset(mask_index) + sprite_get_bbox_left(mask_index);
var x2 = check_x - sprite_get_xoffset(mask_index) + sprite_get_bbox_right(mask_index);
var y1 = check_y - sprite_get_yoffset(mask_index) + sprite_get_bbox_top(mask_index);
var y2 = check_y - sprite_get_yoffset(mask_index) + sprite_get_bbox_bottom(mask_index);

// Check for all colliders at the given area
if (place_meeting(check_x, check_y, ob_colliderNoDepth))
{
	return true;
}

// Check for elevation colliders
var results_colliders = ds_list_create();
var results_colliders_num = collision_rectangle_list(x1, y1, x2, y2, ob_colliderDepth, false, true, results_colliders, false);
for (var i = 0; i < results_colliders_num; ++i)
{
	var collider = results_colliders[|i];
	var collider_z = collider.z;
	var collider_z_height = collider.z_height;
	//if (falling ? (area_z > check_z) : (area_z != check_z))
	//if (falling ? (area_z > check_z + 4) : (abs(area_z - check_z) > 4))
	//if (falling ? (area_z > check_z + 4)
	if (collider_z + collider_z_height > check_z + 4)
	{
		ds_list_destroy(results_colliders);
		return true;
	}
}
ds_list_destroy(results_colliders);

// Check if ignoring elevation
//if (position_meeting(check_x, check_y, ob_elevationBlendArea))
//if (exists(collision_rectangle(check_x - 4, check_y - 4, check_x + 4, check_y + 4, ob_elevationBlendArea, false, true)))
//if (place_meeting(check_x, check_y, ob_elevationBlendArea))
if (position_meeting(x1, y1, ob_elevationBlendArea) 
	&& position_meeting(x2, y1, ob_elevationBlendArea)
	&& position_meeting(x1, y2, ob_elevationBlendArea)
	&& position_meeting(x2, y2, ob_elevationBlendArea))
{
	return false;
}

// Check for all transition zones at the given area
var results = ds_list_create();
var results_num = collision_rectangle_list(x1, y1, x2, y2, ob_elevationArea, false, true, results, false);
// Find the one with the highest z
var area_z_max = -1024;
for (var i = 0; i < results_num; ++i)
{
	var area_z = results[|i].z;
	area_z_max = max(area_z_max, area_z);
}
// Loop through all of them to check collision
for (var i = 0; i < results_num; ++i)
{
	var area_z = results[|i].z;
	if (area_z != area_z_max) continue;
	//if (falling ? (area_z > check_z) : (area_z != check_z))
	if (falling ? (area_z > check_z + 4) : (abs(area_z - check_z) > 4))
	{
		ds_list_destroy(results);
		return true;
	}
}
ds_list_destroy(results);

// No collision
return false;