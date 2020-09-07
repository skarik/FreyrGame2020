/// @function point_on_camera(x, y)
/// @description Checks if the given point is within the current game camera
/// @param x 
/// @param y
function point_on_camera(argument0, argument1) {

	var cam = instance_find(GameCamera, 0);
	var tx = argument0;
	var ty = argument1;

	if (tx < cam.view_x
		|| tx > cam.view_x + cam.width
		|| ty < cam.view_y
		|| ty > cam.view_y + cam.height)
	{
		return false;	
	}
	return true;


}
