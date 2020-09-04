/// @description Check approach state

depthUpdate();

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

if (m_stateWaitingForEndOfCamp)
{
	if (!iexists(o_ctsGameMakeCamp))
	{
		m_stateWaitingForEndOfCamp = false;
		// play sound
		var audio = faudio_create_stream("music/save/save_heavy.ogg");
		var sound = sound_play_at(x, y, audio);
			sound.gain = 0.8;
	}
}

if (m_stateInteracting)
{
	if (!iexists(o_CtsChoiceBox))
	{
		m_stateInteracting = false;
		m_stateInteractingWarping = false;
	}
	else if (!m_stateInteractingWarping)
	{
		if (cutsceneIsChoiceReady())
		{
			var choice = cutsceneGetChoice();
			if (choice == 0)
			{	// Continue
				m_stateInteracting = false;
				
				// save game
				gameSaveSpecific(kSaveFromCheckpointMinor);
				instance_create_depth(x, y - 48, -10, o_floaterGameSaved);
				
				// play continue sound
				var audio = faudio_create_stream("music/save/save_light.ogg");
				var sound = sound_play_at(x, y, audio);
					sound.gain = 0.8;
			}
			else if (choice == 1)
			{	// Short Rest
				m_stateInteracting = false;
				
				// play sound
				var audio = faudio_create_stream("music/save/save_heavy.ogg");
				var sound = sound_play_at(x, y, audio);
					sound.gain = 0.8;
					
				// heal player
				pl.stats.m_health = pl.stats.m_healthMax;
	
				// short rest
				// TODO: make player sit
	
				// respawn all enemies
				gameCampCheckpointShortRest();
	
				// save the checkpoint info
				playerCheckpointSave(x, y + 16, room);
				var fx = instance_create_depth(x, y - 48, -10, o_floaterGameSaved);
				fx.image_alpha = -1.0 * 2.0;
	
				// save game
				gameSaveSpecific(m_majorCheckpoint ? kSaveFromCheckpointMajor : kSaveFromCheckpointMinor);
			}
			else if (choice == 2)
			{	// Long Rest
				m_stateInteracting = false;
				
				// play sound
				var audio = faudio_create_stream("music/save/save_loop.ogg");
				var sound = faudio_play_sound(audio, 50, false, kSoundChannelMusic); //sound_play_at(x, y, audio);
					//sound.gain = 0.8;
					
				// heal player & give full will
				pl.stats.m_health = pl.stats.m_healthMax;
				pl.m_will = pl.m_willMax;
	
				// short rest
				// TODO: make player sit
	
				// respawn all enemies
				gameCampCheckpointLongRest();
	
				// save the checkpoint info
				playerCheckpointSave(x, y + 16, room);
				var fx = instance_create_depth(x, y - 48, -10, o_floaterGameSaved);
				fx.image_alpha = -6.0 * 2.0;
	
				// save game
				gameSaveSpecific(m_majorCheckpoint ? kSaveFromCheckpointMajor : kSaveFromCheckpointMinor);
				
				// go to "wait for end of cutscene" state
				m_stateWaitingForEndOfCamp = true;
				
			}
			else if (choice == 3)
			{	// Warp				
				// remove old menu
				idelete(o_CtsChoiceBox);
				
				// open the teleport menu
				checkpointOpenTeleportMenu();
				
				// switch to interacting state
				m_stateInteracting = true;
				m_stateInteractingWarping = true;
			}
		}
	}
	else
	{
		if (!checkpointStepTeleportMenu())
		{
			m_stateInteracting = false;
			m_stateInteractingWarping = false;
		}
	}
}