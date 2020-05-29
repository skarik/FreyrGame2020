/// @description On pick up,

// Inherit the parent event
event_inherited();

// Disable plugs
if (iexists(energyPlugId))
{
	energyPlugId.m_pot = null;
	energyPlugged = false;
	energyPlugId = null;
}