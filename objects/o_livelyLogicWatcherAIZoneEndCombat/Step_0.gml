/// @description Watch the given AI zone for angry & calm

if (!angry_state)
{
	if (iexists(m_aiZone))
	{
		if (m_aiZone.m_aiAngry)
		{
			angry_state = true;
		}
	}
}
else if (!empty_state)
{
	// Watch for calm state now
	if (iexists(m_aiZone))
	{
		if (!m_aiZone.m_aiAngry && m_aiZone.m_livePopulation == 0)
		{
			empty_state = true;
			event_user(0); // Dispense triggers
		}
	}
}