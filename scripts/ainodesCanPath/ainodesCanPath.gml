/// @description ainodesCanPath(x1, y1, z1, x2, y2)
/// @param x1
/// @param y1
/// @param z1
/// @param x2
/// @param y2
function ainodesCanPath(argument0, argument1, argument2, argument3, argument4) {

	var x1 = argument0;
	var y1 = argument1;
	var z1 = argument2;
	var x2 = argument3;
	var y2 = argument4;

	// Perform a collision check from source to target
	//var current_z = collision3_get_highest_meeting(x1, y1, z1);
	var current_z = collision3_get_highest_position(x1, y1, z1);
	var travel_distance = point_distance(x1, y1, x2, y2);
	var travel_direction = point_direction(x1, y1, x2, y2);
	var travel_step = 8.0;
	for (var dist = travel_step; dist < travel_distance; ++dist)
	{
		var check_x = x1 + lengthdir_x(dist, travel_direction);
		var check_y = y1 + lengthdir_y(dist, travel_direction);
			
		//var collision = collision3_meeting(check_x, check_y, current_z, true);
		var collision = collision3_point_meeting(check_x, check_y, current_z, true); // little faster until we can get better speed
		if (!collision)
		{
			// If no collision, update the Z to the current position and continue.
			//current_z = collision3_get_highest_meeting(check_x, check_y, current_z);
			current_z = collision3_get_highest_position(check_x, check_y, current_z);
		}	
		else
		{	
			// If collision, hit a wall or higher elevation, so not an open connection
			return false;
		}
	}

	return true;


}
