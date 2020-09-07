/// @function iflagsGetValue(id)
/// @param id {GUID}
function iflagsGetValue(argument0) {

	var flag_id = argument0;

	with (kQuestManager)
	{
		var value = iflag_state[?flag_id];
		if (is_undefined(value))
		{
			return 0;
		}
		else
		{
			return value;
		}
	}

	return -1;


}
