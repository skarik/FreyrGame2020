/// @description On Hurt (health > 0)

// Immediately become angry if not already angry:
if (!m_aiCombat_angry)
{
	m_aiCombat_angry = true;
	
	// Update the combat target immediately as well.
	if (iexists(m_lastDamageSource))
	{
		m_aiCombat_target = m_lastDamageSource;
		m_aiCombat_targetPosition = [m_lastDamageSource.x, m_lastDamageSource.y];
		m_aiCombat_targetVisible = true;
	}
}