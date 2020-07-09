/// @description Run the cutscene

// If we're actually at the state we can run the cutscene, run it
if (questGetValue(kQidIntroSequence) >= 50)
{
	// if no OLD, create OLD
	if (!iexists(o_chOld))
	{
		instance_create_depth(480, 0, 0, o_chOld);
		o_chOld.m_interactionFile = "";
		o_chOld.m_interactChoices = 0;
	}
	
	// Check for waits
	if (!cutsceneUpdate())
	{
		var cts_type = cutsceneGetCurrentType();
		
		if (cts_type == SEQTYPE_WAIT)
		{
			var wait_id = cutsceneGetWaitId();
			if (cutsceneGetWaitId() == "OnInteractionWithNPC")
			{
				if (o_chOld.m_wasInteracted)
				{
					cutsceneWaitEnd();
					o_chOld.m_wasInteracted = false;
				}
			}
		}
		
		if (cutsceneIsDone())
		{
			o_chOld.m_interactionFile = "";
		}
	}
}