/// @description collision3_transition_point_meeting(x, y)
/// @param x
/// @param y
function collision3_transition_point_meeting(argument0, argument1) {

	var check_x = argument0;
	var check_y = argument1;

	if (position_meeting(check_x, check_y, ob_elevationBlendArea))
	{
		return true;	
	}

	return col3_internal_tilemap_get_transition(check_x, check_y);


}
