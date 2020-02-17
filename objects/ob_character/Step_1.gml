/// @description Status and Callbacks

// Set up callback states
var do_death_callback = false;
var do_hurt_callback = false;
var do_stun_callback = false;

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
		do_death_callback = true;
	}
	else
	{
		do_hurt_callback = true;
	}
}
stats.m_healthPrev = stats.m_health;

// Check for if stunned
if (stats.m_stun > stats.m_stunPrev)
{
	// Check for stun
	if (stats.m_stun > stats.m_stunMax)
	{
		do_stun_callback = true;
	}
}
stats.m_stunPrev = stats.m_stun;

// Perform callbacks
if (do_death_callback)
{
	event_user(0);
}
if (do_hurt_callback)
{
	event_user(1);
}
if (!do_death_callback && do_stun_callback)
{
	event_user(2);
}