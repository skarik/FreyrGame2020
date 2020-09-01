///@function questSetValue(quest_id, value)
///@param quest_id
///@param value {Integer}
var quest_id = argument0;
var quest_value = argument1;

if (!iexists(kQuestManager)) {
	inew(kQuestManager);
}

with (kQuestManager)
{
	quest_state[quest_id] = quest_value;
}

debugOut("Set quest flag " + string(quest_id) + " to " + string(quest_value));