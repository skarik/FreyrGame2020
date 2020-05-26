var buffer = argument0;

if (!exists(kQuestManager))
{
	show_error("invalid quest state", true);
}

if (!savestateCheckBufferHeader(buffer, kSavestateHeader_Quests))
{
	return;
}

with (kQuestManager)
{
	// init quests
	for (var i = 0; i < kQuestNumber; ++i)
	{
		quest_state[i] = buffer_read(buffer, buffer_s32);
	}
}