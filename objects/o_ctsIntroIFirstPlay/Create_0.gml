/// @description Check Already Played & Init

//if (questGetValue(kQidIntroSequence) > 0)
if (false)
{
	delete(this);
	exit;
}


cutsceneLoad("00_init.txt");


m_initTimer = 0;
m_playerDoodad = null;
m_bubbleTimer = 0;
m_logo = null;