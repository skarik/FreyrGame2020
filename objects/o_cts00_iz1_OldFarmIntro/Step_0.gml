/// @description Run the cutscene

// If we're actually at the state we can run the cutscene, run it
if (questGetValue(kQidIntroSequence) >= 50)
{
	// if no OLD, create OLD
	if (!iexists(o_chOld))
	{
		instance_create_depth(480, 0, 0, o_chOld);
	}
	
	// Check for waits
	if (!cutsceneUpdate())
	{
		var cts_type = cutsceneGetCurrentType();
	}

	// TODO: when it's finished
	if (false)
	{
		o_chOld.m_interactionFile = "00_iz_escortOld_FarmTalk.txt";
	}
}