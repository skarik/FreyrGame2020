/// @description Run the jewels

var pl;
pl = getPlayer();

if (!m_running)
{
	aiscriptRequestStart(o_chNathan, kAiStyle_Lead);
	aiscriptRequestPushPosition(o_chNathan, 400, 600);

	if (pl.y > y)
	{
		aiscriptRequestStart(o_chNathan, kAiStyle_Follow);
		m_running = true;
	}
}
else
{
	// Check for waits
	if (!cutsceneUpdate())
	{
		var cts_type = cutsceneGetCurrentType();
		
		// Make player fall
		if (cts_type == SEQTYPE_WAIT)
		{
			var wait_id = cutsceneGetWaitId();
			if (wait_id == "on_player_till")
			{
				if (exists(o_fieldSquare))
					cutsceneWaitEnd();
			}
			if (wait_id == "on_player_till2")
			{
				var l_tilled = false;
				with (o_fieldSquare)
				{
					if (tilled)
						l_tilled = true;
				}
				
				if (l_tilled)
					cutsceneWaitEnd();
			}
		}
	}
	
	if (cutsceneIsDone())
	{
		//m_name = "Nathan";
		/*m_interactChoices = 4;
		m_interaction[0] = "Hello!";
		m_interaction[1] = "Stay here.";
		m_interaction[2] = "(Crafting)";
		m_interaction[3] = "(Leave)";*/
		o_chNathan.m_interactionFile = "talk00_nathan.txt";

		// Create music manager
		new(o_mus00_DayDesert);
	
		questSetValue(kQidIntroSequence, 40);
		delete(this);
	}
}