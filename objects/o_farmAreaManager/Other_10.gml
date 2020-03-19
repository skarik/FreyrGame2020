/// @description set up id's

if (Debug.convention_mode)
{
	buffer_name = "farm_" + string(Debug.farm_id) + string_replace(room_get_name(room),"rm_","") + ".data";
}
else
{
	buffer_name = "farm_" + string_replace(room_get_name(room),"rm_","") + ".data";
}