function questSave(argument0) {
	var buffer = argument0;

	if (!iexists(kQuestManager))
	{
		show_error("invalid quest state", true);
	}

	savestateWriteBufferHeader(buffer, kSavestateHeader_Quests, kSavestateVersion);

	with (kQuestManager)
	{
		// init quests
		for (var i = 0; i < kQuestNumber; ++i)
		{
			buffer_write(buffer, buffer_s32, quest_state[i]);
		}
	}


}
