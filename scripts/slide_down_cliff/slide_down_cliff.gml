/// @description slide_down_cliff(x, y)
/// @param x
/// @param y

var ob_x = argument0;
var ob_y = argument1;
var ob_z = argument2;

var on_collision = collision3_meeting(ob_x, ob_y, ob_z, true);

if (on_collision == true)
{
	return 0.5; //return the distance to slide down
}

return 0.0; //Don't slide
