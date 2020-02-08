/// @function aicommonCanSee(x, y, z, facing, max_dist, half_angle, use_collision)
/// @desc Checks if the given point can be seen from the current NPC position
/// @param x {Real}
/// @param y {Real}
/// @param z {Real}
/// @param facing {Real}
/// @param max_dist {Real} Max distance of the vision. 0 or lower to skip check.
/// @param half_angle {Real} Max angle of the vision. 180 or higher to skip check.
/// @param use_collision {Boolean} If collisions should be considered when checking. May break w/ elevation.

var tx = argument0;
var ty = argument1;
var tz = argument2;
var tfacing = argument3;

var max_dist = argument4;
var half_angle = argument5;
var use_collision = argument6;

var use_dist = max_dist > 0;
var use_angle = half_angle < 180;

// do distance check
if (!use_dist
	|| point_distance(x, y, tx, ty) < max_dist)
{
	// do visibility angle check
	if (!use_angle
		|| abs(angle_difference(point_direction(x, y, tx, ty), tfacing)) < half_angle)
	{
		// do occlusion visibility check
		if (!use_collision || !collision3_line(x, y, tx, ty, tz, true))
		{
			return true; // can see
		}
	}
}

return false;