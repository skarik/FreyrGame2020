/// @description On KOed (health == 0)

// Inherit the parent event
event_inherited();

// Dying animation
if (!iexists(o_ctsDeathCutscene))
{
	inew(o_ctsDeathCutscene);
}

m_isKOed = true;