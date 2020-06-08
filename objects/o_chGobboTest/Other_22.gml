/// @description AI On Angry

if (!m_isKOed && !m_isDead && !m_aiCombat_angry)
{
	m_aiCombat_angry = true;
	
	// Alert all the other folks nearby
	if (iexists(m_aialert_area))
	{
		var alert_area = m_aialert_area;
		var callee = id;
		with (object_index)
		{
			if (m_aialert_area == alert_area)
			{
				m_aiCombat_target = callee.m_aiCombat_target; // will this even work?
				event_user(kEvent_AIOnAngry12);
			}
		}
	}
}