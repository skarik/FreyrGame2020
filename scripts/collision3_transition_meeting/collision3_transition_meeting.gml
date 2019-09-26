/// @description *collision3_transition_meeting(x, y)
/// @param x
/// @param y

var check_x = argument0;
var check_y = argument1;

var x1 = check_x - sprite_get_xoffset(mask_index) + sprite_get_bbox_left(mask_index);
var x2 = check_x - sprite_get_xoffset(mask_index) + sprite_get_bbox_right(mask_index);
var y1 = check_y - sprite_get_yoffset(mask_index) + sprite_get_bbox_top(mask_index);
var y2 = check_y - sprite_get_yoffset(mask_index) + sprite_get_bbox_bottom(mask_index);

if (place_meeting(check_x, check_y, ob_elevationBlendArea))
{
	return true;	
}

return 
	col3_internal_tilemap_get_transition(x1, y1) ||
	col3_internal_tilemap_get_transition(x2, y1) ||
	col3_internal_tilemap_get_transition(x1, y2) ||
	col3_internal_tilemap_get_transition(x2, y2);