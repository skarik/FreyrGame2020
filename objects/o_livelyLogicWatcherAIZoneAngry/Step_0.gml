/// @description Watch the given AI zone for angry

if (!angry_state)
{
	if (iexists(m_aiZone))
	{
		if (m_aiZone.m_aiAngry)
		{
			angry_state = true;
			event_user(0); // Dispense triggers
		}
	}
}