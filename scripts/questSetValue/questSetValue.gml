var quest_id = argument0;
var quest_value = argument1;

if (!iexists(kQuestManager)) {
	inew(kQuestManager);
}

with (kQuestManager)
{
	quest_state[quest_id] = quest_value;
}
