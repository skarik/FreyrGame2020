///@param quest_id
function questGetValue(argument0) {
	var quest_id = argument0;

	with (kQuestManager)
	{
		return quest_state[quest_id];
	}

	return -1;


}
