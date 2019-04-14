/// @description Check Already Played & Init
m_initialized = false;

if (questGetValue(kQidIntroSequence) > 0)
{
	delete(this);
	exit;
}


cutsceneLoad("00_intro.txt");

questSetValue(kQidIntroSequence, 10);

m_initialized = true;