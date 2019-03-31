var quest_id = argument0;
var quest_value = argument1;

with (kQuestManager)
{
	quest_state[quest_id] = quest_value;
}
