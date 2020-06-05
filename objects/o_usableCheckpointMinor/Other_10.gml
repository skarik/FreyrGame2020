/// @description Default inspection
var pl = getPlayer();
if (m_usable && iexists(m_user) && m_user.id == pl.id)
{
	/*if (!iexists(ob_CtsTalker))
	{
		ctsMakeGabber(m_user, "Self", "It's a $b" + m_name + "$$.");
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		inew(o_CtsReenablePlayerOnCtsEnd);
	}*/
	
	// unlock if major
	if (m_majorCheckpoint)
	{
		checkpointInfoUnlock(id);
	}
	
	// play audio
	var audio = sound_play_at(x, y, snd_CheckpointTouch);
		audio.gain = 0.9;
	
	if (!iexists(ob_CtsTalker))
	{
		// Ask for if we want to restart at last checkpoint or at the farm
		var gabber = inew(o_CtsChoiceBox);
			gabber.input_choice_count = m_majorCheckpoint ? 3 : 2;
			gabber.input_choice[0] = "Continue";
			gabber.input_choice[1] = "Rest";
			gabber.input_choice[2] = "Warp";
			gabber.input_actor = id;
			gabber.display_width = 70;
			gabber.display_blackbox_override = true;
			
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		inew(o_CtsReenablePlayerOnCtsEnd);
	}
	
	m_stateInteracting = true;
	
	// unlock if major
	/*if (m_majorCheckpoint)
	{
		checkpointInfoUnlock(id);
	}
	
	// play audio
	var audio = sound_play_at(x, y, snd_CheckpointClassic);
	
	// heal player
	pl.stats.m_health = pl.stats.m_healthMax;
	
	// short rest
	// TODO: make player sit
	
	// respawn all enemies
	gameCampCheckpointShortRest();
	
	// save the checkpoint info
	playerCheckpointSave(x, y + 16, room);
	
	// save game
	gameSaveSpecific(kSaveFromCheckpointMinor);*/
}