/// @description Delete or set alarm
if (iexists(o_PlayerTest))
{
	idelete(this);
}
else
{
	alarm[0] = 1;
	
	questSetValue(kQidIntroSequence, m_questIntroSequence);
}