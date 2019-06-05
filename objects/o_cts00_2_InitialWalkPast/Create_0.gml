/// @description Check Already Played & Init
m_initialized = false;

if (questGetValue(kQidIntroSequence) > 20)
{
	if (questGetValue(kQidIntroSequence) <= 30)
	{
		aiscriptRequestPushPosition(o_chNathan, 490, 1050);
	}
	
	delete(this);
	exit;
}

// Load the cutscene
cutsceneLoad("00_initialLanding3.txt");

// Set up variables
m_running = false;

// Mark as ready
m_initialized = true;