/// @description 

// Inherit the parent event
event_inherited();

moCanMoveUnstuck = false;
m_bloodType = kBloodMetal;
kKickbackAmount = 0.5;
m_canKnockout = false;

image_speed = 0.0;
animationIndex = 0.0;

with (stats)
{
	m_health = 2;
	m_healthMax = m_health;
	m_healthPrev = m_health;
}

xstart = x;
ystart = y;

m_empty = false;

// Check if already opened
if (iflagsGetValue(id) > 0)
{
	m_isKOed = true;
	m_empty = true;
}