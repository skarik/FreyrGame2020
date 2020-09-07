/// @function iflagsSetValue(id, value)
/// @param id {GUID}
/// @param value {Real}
function iflagsSetValue(argument0, argument1) {

	var flag_id = argument0;
	var flag_value = argument1;

	if (!iexists(kQuestManager)) {
		inew(kQuestManager);
	}

	with (kQuestManager)
	{
		iflag_state[?flag_id] = flag_value;
	}

	debugOut("Set instance flag " + string(flag_id) + " to " + string(flag_value));


}
