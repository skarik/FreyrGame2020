/// @description set music

// todo: actually play the music

if (!timeofdayIsDaytime())
{
	delete(this);
	new(o_mus00_NightDesert);
	exit;
}

var enemies_aggro = false;
with (o_chGobboTest)
{
	if (m_aiCombat_angry) {
		enemies_aggro = true;	
	}
}
if (enemies_aggro)
{
	delete(this);
	new(o_mus00_CombatDesert);
	exit;
}

//var pl = getPlayer();

m_trackVolume[0] = 1.0;

event_inherited();