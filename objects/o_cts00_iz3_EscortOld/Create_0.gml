/// @description Load cutscene

if (questGetValue(kQidIntroSequence) >= 1000)
{
	idelete(this);
	exit;
}

cutsceneLoad("00_iz_escortOld3_TravelDialogue.txt");
