/// @function timeofdayDelta(time1_hours, time1_day, time2_hours, time2_day)
/// @description Calculates difference in hours between the two given times
function timeofdayDelta(argument0, argument1, argument2, argument3) {

	return (argument0 - argument2) + 24.0 * (argument1 - argument3);


}
