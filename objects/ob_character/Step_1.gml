/// @description Status and Callbacks

// Check for stun timer
if (m_stunTimer <= 0.0)
{
	m_isStunned = false;
}
m_stunTimer -= Time.deltaTime;

// Check for if hurt
if (stats.m_health < stats.m_healthPrev)
{
	// Check for death
	if (stats.m_health <= 0 && !m_isDead)
	{
		event_user(0);
	}
	else
	{
		event_user(1);
	}
}
stats.m_healthPrev = stats.m_health;