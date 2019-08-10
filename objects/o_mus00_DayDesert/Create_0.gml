/// @description set tracks

if (!timeofdayIsDaytime())
{
	delete(this);
	new(o_mus00_NightDesert);
	exit;
}

/*if (questGetValue(kQidIntroSequence) < 10)
{
	delete(this);
	exit;
}*/

event_inherited();

// set up tracks
m_tracks = array_create(1);
m_tracks[0] = "audio/wei_DayLoop.ogg";