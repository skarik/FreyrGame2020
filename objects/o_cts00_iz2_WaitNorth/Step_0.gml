/// @description Run the cutscene

// If we're actually at the state we can run the cutscene, run it
if (questGetValue(kQidIntroSequence) >= 60)
{
	// Check for waits
	if (!cutsceneUpdate())
	{
		var cts_type = cutsceneGetCurrentType();
		
		if (cts_type == SEQTYPE_WAIT)
		{
			var wait_id = cutsceneGetWaitId();
			if (wait_id == "OnInteractionWithNPC")
			{
				o_chOld.m_interactionFile = "";
				if (o_chOld.m_wasInteracted)
				{
					cutsceneWaitEnd();
					o_chOld.m_wasInteracted = false;
				}
			}
		}
		
		if (cutsceneIsDone())
		{
			idelete(this);
		}
	}
}