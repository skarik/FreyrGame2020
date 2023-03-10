function questLoad(argument0) {
	var buffer = argument0;

	if (!iexists(kQuestManager))
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


}
