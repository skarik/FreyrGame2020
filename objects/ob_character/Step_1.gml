/// @description Status and Callbacks

// Set up callback states
var do_knockout_callback = false;
var do_hurt_callback = false;
var do_stun_callback = false;
var do_death_callback = false;

// Check for stun timer
m_stunTimer -= Time.deltaTime;
if (m_isStunned) // If stunned, then the moment the counter hits zero, reset stun value.
{	
	if (m_stunTimer <= 0.0)
	{
		stats.m_stun = 0.0; // Refresh stun timer when stun ends.
	}
}
// Force disable stun when stun timer is below zero
if (m_stunTimer <= 0.0)
{
	m_isStunned = false;
}
// Force reset stun meter when taking a break for a while
if (m_stunTimer <= -10.0)
{
	stats.m_stun = max(0, stats.m_stun - Time.deltaTime * 0.1);
}

// Check for if hurt
if (stats.m_health < stats.m_healthPrev)
{
	// Reset stun countdown
	m_stunTimer = max(0.0, m_stunTimer);
	
	// Update on-hurt marker
	stats.m_healthLastHit = stats.m_healthPrev;
	
	// Check for knockout
	if (stats.m_health <= 0 && !m_isKOed)
	{
		do_knockout_callback = true;
		if (m_dieInsteadOfKO)
		{
			do_death_callback = true;
		}
	}
	else
	{
		do_hurt_callback = true;
	}
	
	// Do death checks
	if (m_isKOed)
	{
		stats.m_kohits -= 1;
		
		if (stats.m_kohits <= 0 && !m_isDead)
		{
			do_death_callback = true;
		}
	}
}
stats.m_healthPrev = stats.m_health;
stats.m_kohitsPrev = stats.m_kohits;

// Check for if stunned
if (stats.m_stun > stats.m_stunPrev)
{
	// Reset stun countdown
	m_stunTimer = max(0.0, m_stunTimer);
	
	// Check for stun
	if (stats.m_stun >= stats.m_stunMax)
	{
		do_stun_callback = true;
	}
}
stats.m_stunPrev = stats.m_stun;

// Perform callbacks
if (do_hurt_callback)
{
	event_user(kEvent_ChOnHurt1);
}
if (!do_knockout_callback && !do_death_callback && do_stun_callback)
{
	event_user(kEvent_ChOnStun2);
}
if (do_knockout_callback)
{
	event_user(kEvent_ChOnKO0);
}
if (do_death_callback)
{
	event_user(kEvent_ChOnDeath4);
}