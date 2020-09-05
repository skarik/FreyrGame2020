/// @description Check Already Played & Init
m_initialized = false;

//questSetValue(kQidIntroSequence, 10); // DEBUG

if (questGetValue(kQidIntroSequence) != 10)
{
	inew_unique(o_mus00_Oasis);
	idelete(this);
	exit;
}

// Load the cutscene
cutsceneLoad("00_initialLanding2.txt");

// Mark as ready
m_initialized = true;