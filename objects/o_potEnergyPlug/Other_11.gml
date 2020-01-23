/// @description On pick up,

// Inherit the parent event
event_inherited();

// Disable plugs
if (exists(energyPlugId))
{
	energyPlugId.m_pot = null;
	energyPlugged = false;
	energyPlugId = null;
}