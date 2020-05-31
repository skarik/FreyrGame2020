/// @description set music

// todo: actually play the music

/*if (!timeofdayIsDaytime())
{
	idelete(this);
	inew(o_mus00_NightDesert);
	exit;
}*/

var enemies_aggro = false;
with (o_chGobboTest)
{
	if (m_aiCombat_angry) {
		enemies_aggro = true;	
	}
}
if (!enemies_aggro)
{
	idelete(this);
	inew(o_mus00_DayDesert);
	exit;
}


//var pl = getPlayer();

m_trackVolume[0] = 1.0;

event_inherited();