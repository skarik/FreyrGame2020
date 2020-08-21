/// @description AI On Alert

if (!m_isKOed && !m_isDead && !m_aiCombat_alerted)
{
	// Create the ? emote
	var emote_fx = inew(o_fxEmote);
		emote_fx.m_target = id;
		emote_fx.image_index = 1;
	
	// Set new state
	m_aiCombat_alerted = true;
	
	// Reset aggro timer
	/*m_aiCombat_aggroTimer = 0.0;
	m_aiCombat_targetTrackingLossTime = 0.0;*/
	
	// Alert all the other folks nearby
	if (iexists(m_aialert_area))
	{
		/*var alert_area = m_aialert_area;
		var callee = id;
		with (m_aiGobbo_baseObject)
		{
			if (m_aialert_area == alert_area)
			{
				m_aiCombat_target = callee.m_aiCombat_target;
				m_aiCombat_targetPosition = [callee.m_aiCombat_targetPosition[0], callee.m_aiCombat_targetPosition[1]];
				event_user(kEvent_AIOnAlert11);
			}
		}*/
		
		// Alert the area
		with (m_aialert_area)
		{
			event_user(kEvent_AIOnAlert11);
		}
	}
}