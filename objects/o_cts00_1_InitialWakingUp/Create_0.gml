/// @description Check Already Played & Init
m_initialized = false;

if (questGetValue(kQidIntroSequence) != 10)
{
	new(o_mus00_Oasis);
	delete(this);
	exit;
}

// Load the cutscene
cutsceneLoad("00_initialLanding2.txt");

// Mark as ready
m_initialized = true;