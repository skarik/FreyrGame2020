/// @description set up id's

if (Debug.convention_mode)
{
	buffer_name = "farm_" + string(Debug.farm_id) + room_get_name(room) + ".data";
}
else
{
	buffer_name = "farm_" + room_get_name(room) + ".data";
}