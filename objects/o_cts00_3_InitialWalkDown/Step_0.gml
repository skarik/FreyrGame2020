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
				if (m_prev_fieldSquareCount == null)
				{
					m_prev_fieldSquareCount = instance_number(o_fieldSquare);
				}
				if (m_prev_fieldSquareCount < instance_number(o_fieldSquare))
				{
					cutsceneWaitEnd();
					m_music_state = 1;
				}
			}
			if (wait_id == "on_player_till2")
			{
				var callee = id;
				if (m_prev_fieldTillCount == null)
				{
					// Count number of tilled
					m_prev_fieldTillCount = 0;
					with (o_fieldSquare)
					{
						if (tilled)
						{
							callee.m_prev_fieldTillCount++;
						}
					}
				}
				
				var l_tilledCount = 0;
				with (o_fieldSquare)
				{
					if (tilled)
					{
						l_tilledCount++
					}
				}
				
				if (m_prev_fieldTillCount < l_tilledCount)
				{
					cutsceneWaitEnd();
					m_music_state = 2;
				}
			}
		}
	}
	
	if (cutsceneIsDone())
	{
		m_music_state = 3;
		//m_name = "Nathan";
		/*m_interactChoices = 4;
		m_interaction[0] = "Hello!";
		m_interaction[1] = "Stay here.";
		m_interaction[2] = "(Crafting)";
		m_interaction[3] = "(Leave)";*/
		o_chNathan.m_interactionFile = "talk00_nathan.txt";

		// Create music manager
		//inew(o_mus00_DayDesert);
	
		questSetValue(kQidIntroSequence, 40);
		idelete(this);
	}
}