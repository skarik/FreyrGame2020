/// @description Check Already Played & Init
m_initialized = false;

if (questGetValue(kQidIntroSequence) > 55)
{
	idelete(this);
	exit;
}

// Load the cutscene
cutsceneLoad("00_iz_escortOld1_FarmIntro.txt");

// Mark as ready
m_initialized = true;
