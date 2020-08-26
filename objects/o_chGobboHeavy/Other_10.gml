/// @description On KO (health < 0)

// Inherit the parent event
event_inherited();

// Destroy the colliders
for (var i = 0; i < array_length_1d(m_colliders); ++i)
{
	m_colliders[i].m_fadeOut = true;
}