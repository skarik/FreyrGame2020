/// @description Check Already Played & Init
m_initialized = false;

if (questGetValue(kQidViggoFirstCards) >= 1)
{
	idelete(this);
	exit;
}

questSetValue(kQidViggoFirstCards, 0);

m_initialized = true;
m_state = 0;

cutsceneLoad("00_foolsmarch_viggocards.txt");

// find viggo and make him sit
var viggo = o_chViggo;
if (iexists(viggo))
{
	viggo.kAnimStanding = s_charViggoSit;
	viggo.m_name = "???";
}