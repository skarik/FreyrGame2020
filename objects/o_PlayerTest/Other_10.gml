/// @description On Death...

// Inherit the parent event
event_inherited();

// Dying animation
if (!exists(o_ctsDeathCutscene))
{
	new(o_ctsDeathCutscene);
}