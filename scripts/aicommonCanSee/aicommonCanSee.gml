/// @function aicommonCanSee(x, y, z, facing, max_dist, half_angle, use_collision)
/// @desc Checks if the given point can be seen from the current NPC position
/// @param {Real} x
/// @param {Real} y
/// @param {Real} z
/// @param {Real} facing
/// @param {Real} max_dist Max distance of the vision. 0 or lower to skip check.
/// @param {Real} half_angle Max angle of the vision. 180 or higher to skip check.
/// @param {Boolean} use_collision  If collisions should be considered when checking. May break w/ elevation.
function aicommonCanSee(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {

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
			if (!use_collision
				|| !collision3_line(x, y, tx, ty, min(z, tz), true))
			{
				return true; // can see
			}
		}
	}

	return false;


}
