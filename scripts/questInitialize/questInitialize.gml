function questInitialize() {
	// check is valid quest manager
	var other_id = id;
	with (kQuestManager)
	{
		if (other_id != id)
		{
			show_error("invalid quest manager", true);
		}
	}

	// init quests
	for (var i = 0; i < kQuestNumber; ++i)
	{
		quest_state[i] = 0;
	}

	// set persistence
	persistent = true;

	// initialized quest system
	debugOut("initialized quest state array");


}
