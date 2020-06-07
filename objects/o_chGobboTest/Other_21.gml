/// @description AI On Alert

if (!m_isKOed && !m_isDead && !m_aiCombat_alerted)
{
	m_aiCombat_alerted = true;
	
	// Alert all the other folks nearby
	if (iexists(m_aialert_area))
	{
		var alert_area = m_aialert_area;
		with (object_index)
		{
			if (m_aialert_area == alert_area)
			{
				event_user(kEvent_AIOnAlert11);
			}
		}
	}
}