/// @description Run parent event & update light

// run light
if (exists(m_light))
{
	m_light.x = x;
	m_light.y = y;
}

event_inherited();