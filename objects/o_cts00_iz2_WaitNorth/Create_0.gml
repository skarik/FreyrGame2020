/// @description Check Already Played & Init
m_initialized = false;

if (questGetValue(kQidIntroSequence) > 60)
{
	idelete(this);
	exit;
}

// Load the cutscene
cutsceneLoad("00_iz_escortOld2_Stuff.txt");

// Mark as ready
m_initialized = true;
