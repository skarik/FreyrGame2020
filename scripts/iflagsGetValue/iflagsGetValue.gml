/// @function iflagsGetValue(id)
/// @param id {GUID}
function iflagsGetValue(inst_id)
{
	var flag_id = inst_id; // TODO This needs to be a lot more resilient to room changes.
	// Likely need to store both room name as string & object count of the current instance.
 
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
