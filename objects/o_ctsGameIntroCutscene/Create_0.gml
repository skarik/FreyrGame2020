/// @description Check Already Played & Init

if (questGetValue(kQidIntroSequence) > 0)
{
	delete(this);
	exit;
}


cutsceneLoad("00_intro.txt");