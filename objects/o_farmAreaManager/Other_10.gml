/// @description set up id's

if (Debug.convention_mode)
{
	buffer_name = "farm_" + string(Debug.farm_id) + string(room) + ".data";
}
else
{
	buffer_name = "farm_" + string(room) + ".data";
}