/// @description slide_down_cliff(x, y, z)
/// @param x
/// @param y
/// @param z
function slide_down_cliff(argument0, argument1, argument2) {

	var ob_x = argument0;
	var ob_y = argument1;
	var ob_z = argument2;

	var on_collision = collision3_meeting(ob_x, ob_y, ob_z, true);

	if (on_collision == true)
	{
		return 10; //return the distance to slide down per second
	}

	return 0.0; //Don't slide



}
