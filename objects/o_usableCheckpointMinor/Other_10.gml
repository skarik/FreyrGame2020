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
	gameSaveSpecific(kSaveFromCheckpointMinor);
}