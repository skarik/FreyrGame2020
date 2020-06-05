/// @description Check approach state

var pl = getPlayer();
var pl_dist_sqr = sqr(x - pl.x) + sqr(y - pl.y);
var glow_dist_sqr = sqr(80);

if (!m_statePlayerNearby)
{
	if (pl_dist_sqr < glow_dist_sqr)
	{
		m_statePlayerNearby = true;
	}
}
else
{
	if (pl_dist_sqr > glow_dist_sqr)
	{
		m_statePlayerNearby = false;
	}
}

if (m_stateInteracting)
{
	if (!iexists(o_CtsChoiceBox))
	{
		m_stateInteracting = false;
	}
	else
	{
		if (cutsceneIsChoiceReady())
		{
			var choice = cutsceneGetChoice();
			if (choice == 0)
			{	// Continue
				m_stateInteracting = false;
			}
			else if (choice == 1)
			{	// Rest
				m_stateInteracting = false;
				
				// play sound
				var audio = sound_play_at(x, y, snd_CheckpointClassic);
					audio.gain = 0.8;
					
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
			else if (choice == 2)
			{	// Warp
				m_stateInteracting = false;
			}
		}
	}
}