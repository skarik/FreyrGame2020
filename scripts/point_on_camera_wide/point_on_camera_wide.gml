/// @function point_on_camera_wide(x, y, margin_x, margin_y)
/// @description Checks if the given point is within the current game camera
/// @param x 
/// @param y
/// @param margin_x 
/// @param margin_y

var cam = instance_find(GameCamera, 0);
var tx = argument0;
var ty = argument1;
var margin_x = argument2;
var margin_y = argument3;

if (tx < cam.x - margin_x
	|| tx > cam.x + cam.width + margin_x
	|| ty < cam.y - margin_y
	|| ty > cam.y + cam.height + margin_y)
{
	return false;	
}
return true;