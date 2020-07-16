/// @description ctsupdate

// Skip if we're not yet ready.
if (questGetValue(kQidIntroSequence) < 20)
{
	exit;
}

if (!m_running)
{
	o_chNathan.isPassthru = true;
	
	o_chNathan.m_interactChoices = 2;
	o_chNathan.m_interaction[0] = "(Isn't it hot?)"
	o_chNathan.m_interaction[1] = "(Leave)";
	o_chNathan.m_interactionFile = "";
	o_chNathan.m_interactionObject.m_actionName = "Talk";
	
	if (iexists(o_CtsChoiceBox))
	{
		if (cutsceneIsChoiceReady())
		{
			if (cutsceneGetChoice() == 0)
			{
				m_running = true;
			}
		}
	}
	
	if (o_PlayerTest.x > o_chNathan.x + 8)
	{
		m_running = true;
	}
}
else
{
	o_chNathan.m_interactChoices = 0;
	//o_chNathan.m_interaction[0] = "Say hello!"
	//o_chNathan.m_interaction[1] = "(Leave)";
	o_chNathan.m_interactionFile = "";//"talk00_nathan.txt";
	o_chNathan.m_interactionObject.m_actionName = "Greet";
}

if (m_running)
{
	var pl = getPlayer();

	// Check signals
	if (cutsceneHasSignal())
	{
		var signal_id = cutsceneGetSignal();
	
		if (signal_id == "lock_player")
		{
			pl.canMove = false; // Disable all motion input
			pl.onGround = true;
			pl.moEnabled = false;
			pl.zspeed = 0.0;
			pl.sprite_index = pl.kAnimStanding;
			
			// Stop motion
			pl.xspeed = 0.0;
			pl.yspeed = 0.0;
		
			// Don't consume the signal.
		}
		/*if (signal_id == "give_player_seeds")
		{
			// Create seed item
			repeat (20)
				instance_create_depth(pl.x, pl.y, pl.depth - 1, o_pickupSeed_Turnip);
			
			// Consume the signal
			cutsceneSignalConsume();
		}*/
		if (signal_id == "ended")
		{
			// Make nathan not passthru
			o_chNathan.isPassthru = false;
			// Unlock player
			pl.canMove = true;
			pl.moEnabled = true;
			pl.moAnimationPlayback = false;
			// Put Nathan in the player party
			playerPartyAdd(o_chNathan);
			// Set the final flag
			questSetValue(kQidIntroSequence, 30);
			// Create music manager
			inew(o_mus00_Oasis);
			// Consume!
			cutsceneSignalConsume();
			// Delete self
			idelete(this);
		}
	}

	// Check for waits
	if (!cutsceneUpdate())
	{
		var cts_type = cutsceneGetCurrentType();
		
		// Make player fall
		if (cts_type == SEQTYPE_WAIT)
		{
			var wait_id = cutsceneGetWaitId();
			if (wait_id == "on_player_outside")
			{
				// Consume all signals now
				cutsceneSignalConsume();
				
				// Unlock player
				pl.canMove = true;
				pl.moEnabled = true;
				pl.moAnimationPlayback = false;
				
				// Check if player is outside
				if (o_doodadTentChonkHider.image_alpha >= 1.0)
				{
					// Stop player then
					pl.canMove = false; // Disable all motion input
					pl.onGround = true;
					pl.moEnabled = false;
					pl.zspeed = 0.0;
			
					// Stop motion
					pl.xspeed = 0.0;
					pl.yspeed = 0.0;
					
					// Contine onward
					cutsceneWaitEnd();
				}
			}
			/*if (wait_id == "give_player_seeds")
			{
				if (!iexists(o_pickupSeed_Turnip))
				{
					cutsceneWaitEnd();
				}
			}*/
		}
		// continue~
	}
}