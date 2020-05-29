/// @description Check Already Played & Init
m_initialized = false;

if (questGetValue(kQidIntroSequence) > 0)
{
	idelete(this);
	exit;
}

// Set constants
kFallHeight = 280;

// Load the cutscene
cutsceneLoad("00_initialLanding.txt");
//questSetValue(kQidIntroSequence, 10);

// Mark as ready
m_initialized = true;