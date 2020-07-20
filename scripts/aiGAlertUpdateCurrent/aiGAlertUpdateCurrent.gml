var t_aiAlertNextArea = m_aialert_area;
var t_aiAlertArea = collision_point(x, y, ob_areaAINotify, false, true);
if (iexists(t_aiAlertArea))
{
	if (m_aialert_collidingArea != t_aiAlertArea)
	{
		// Switch to new colliding area
		m_aialert_collidingArea = t_aiAlertArea;
		t_aiAlertNextArea = (t_aiAlertArea.m_parentArea == null) ? t_aiAlertArea : t_aiAlertArea.m_parentArea;
	}
}

// If we have a new alert area, then switch to that
if (m_aialert_area != t_aiAlertNextArea)
{
	m_aialert_area = t_aiAlertNextArea;
	
	if (iexists(t_aiAlertNextArea))
	{
		/*if (m_aiCombat_alerted && !t_aiAlertNextArea.m_aiAlerted)
		{
			with (t_aiAlertNextArea)
			{	
				event_user(kEvent_AIOnAlert11);
			}
		}
		if (m_aiCombat_angry && !t_aiAlertNextArea.m_aiAngry)
		{
			with (t_aiAlertNextArea)
			{	
				event_user(kEvent_AIOnAngry12);
			}
		}
		
		// Do catchup callbacks
		if (t_aiAlertNextArea.m_aiAlerted)
		{
			event_user(kEvent_AIOnAlert11);
		}
		if (t_aiAlertNextArea.m_aiAngry)
		{
			event_user(kEvent_AIOnAngry12);
		}*/
		/*if (m_aiCombat_alerted)
		{
			with (object_index)
			{
				
			}
		}*/
	}
}