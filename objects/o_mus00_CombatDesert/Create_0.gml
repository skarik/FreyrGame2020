/// @description set tracks

/*if (!timeofdayIsDaytime())
{
	idelete(this);
	inew(o_mus00_NightDesert);
	exit;
}*/

/*if (questGetValue(kQidIntroSequence) < 10)
{
	idelete(this);
	exit;
}*/

event_inherited();

// set up tracks
m_tracks = array_create(1);
m_tracks[0] = "audio/wei_BattleDayLoop.ogg";