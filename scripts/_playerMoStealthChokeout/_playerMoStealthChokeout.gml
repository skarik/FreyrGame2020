isAttacking = true;

if (atkButton.value > 0.707
	&& iexists(m_attackKnockoutTarget)
	&& !m_tookDamage)
{
	m_moveCharge += Time.deltaTime;
}
else
{
	if (m_moveCharge >= 1.0 && !m_tookDamage)
	{
		if (iexists(m_attackKnockoutTarget))
		{
			m_attackKnockoutTarget.m_isKOed = true;
			with (m_attackKnockoutTarget)
			{
				event_user(kEvent_ChOnKO0);
			}
		}
	}
	else
	{
		// Notify the AI the choke didn't happen
	}
	
	isAttacking = false;
	moScriptOverride = null;
}