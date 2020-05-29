/// @description On Death...

// Inherit the parent event
event_inherited();

// Dying animation
if (!iexists(o_ctsDeathCutscene))
{
	inew(o_ctsDeathCutscene);
}