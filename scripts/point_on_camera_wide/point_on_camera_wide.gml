/// @function point_on_camera_wide(x, y, margin_x, margin_y)
/// @description Checks if the given point is within the current game camera
/// @param x 
/// @param y
/// @param margin_x 
/// @param margin_y
function point_on_camera_wide(argument0, argument1, argument2, argument3) {

	var cam = GameCamera.id;//instance_find(GameCamera, 0);
	var tx = argument0;
	var ty = argument1;
	var margin_x = argument2;
	var margin_y = argument3;

	if (tx < cam.view_x - margin_x
		|| tx > cam.view_x + cam.width + margin_x
		|| ty < cam.view_y - margin_y
		|| ty > cam.view_y + cam.height + margin_y)
	{
		return false;	
	}
	return true;


}
