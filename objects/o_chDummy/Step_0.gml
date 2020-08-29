/// @description Motion (Inherited) & Revive

// Inherit the parent event
event_inherited();

{
	// TODO: move the following to a defaul type of health/stamina shown
	var pl = getPlayer();
	var pl_dist = sqr(1024);
	if (iexists(pl)) pl_dist = sqr(x - pl.x) + sqr(y - pl.y);
	// Update health showing
	if (stats.m_health < stats.m_healthMax || pl_dist < sqr(48)) 
		m_uiwantsHealthShown = true;
	else
		m_uiwantsHealthShown = false;
	
	if (stats.m_health < stats.m_healthMax || stats.m_stun > 0 || pl_dist < sqr(48))
		m_uiwantsStaminaShown = true;
	else
		m_uiwantsStaminaShown = false;
}

if (m_isKOed || m_isDead)
{
	m_reviveTimer -= Time.deltaTime;
	if (m_reviveTimer <= 0.0)
	{
		// Reset states
		m_isKOed = false;
		m_isDead = false;
		m_isStunned = false;
		
		// Heal & reset stun
		stats.m_health = stats.m_healthMax;
		stats.m_stun = 0;
	}
}