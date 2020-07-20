/// @description On Hurt (health > 0)

// Stealth hit KO
if (!m_aiCombat_alerted)
{
	if (iexists(m_lastDamageSource)
		&& m_lastDamageSource.m_isPlayer && m_lastDamageSource.isHidden)
	{
		stats.m_stun += stats.m_stunMax;
		stats.m_health -= ceil(stats.m_healthMax * 0.5);
	}
}

// hacky way to get gobbos to respond to damage
if (iexists(m_lastDamageSource))
{
	if (!m_aiCombat_angry || !iexists(m_aiCombat_target))
	{
		m_aiCombat_target = m_lastDamageSource;
	}
}
//m_aiCombat_angry = true;
event_user(kEvent_AIOnAngry12);
