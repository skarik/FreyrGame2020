/// @description On Stun (stun > max)

// Inherit the parent event
//event_inherited();

// And then override the hell out of it:

stats.m_stun = 0.0;

// Ministun if out of Will
if (m_willStyleStun)
{
	m_isStunned = true;
	m_stunTimer = max(0, m_stunTimer) + 0.6;
	
	m_willStyleStun = false; // Reset will-style stun flag
}
// Normal stun otherwise (small for player)
else
{
	m_isStunned = true;
	m_stunTimer = max(0, m_stunTimer) + 1.0;
}