/// @description On Hurt (health > 0)


// hacky way to get gobbos to respond to damage
if (exists(m_lastDamageSource))
{
	if (!m_aiCombat_angry || !exists(m_aiCombat_target))
	{
		m_aiCombat_target = m_lastDamageSource;
	}
}
m_aiCombat_angry = true;
