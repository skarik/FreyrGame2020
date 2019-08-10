/// @description set music

// todo: actually play the music

if (timeofdayIsDaytime())
{
	delete(this);
	new(o_mus00_DayDesert);
	exit;
}

//var pl = getPlayer();

m_trackVolume[0] = 1.0;

event_inherited();