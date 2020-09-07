function checkpointStepTeleportMenu() {
	if (cutsceneIsChoiceReady())
	{
		var choice = cutsceneGetChoice() - 1;
		if (choice == -1)
		{
			return false; // We done.
		}
		else
		{
			// Get the checkpoint info
			var checkpoint_info = kQuestManager.checkpoint_list[choice];
			checkpointTeleportTo(checkpoint_info[0], checkpoint_info[1]);
			return false;
		}
	}
	return true;


}
