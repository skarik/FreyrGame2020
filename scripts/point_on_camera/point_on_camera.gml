/// @function point_on_camera(x, y)
/// @description Checks if the given point is within the current game camera
/// @param x 
/// @param y

var cam = instance_find(GameCamera, 0);
var tx = argument0;
var ty = argument1;

if (tx < cam.x
	|| tx > cam.x + cam.width
	|| ty < cam.y
	|| ty > cam.y + cam.height)
{
	return false;	
}
return true;