/// @description Open/close

// update camera culling using doodad code
event_perform_object(ob_doodad, ev_user0, 0);

if (m_moving)
{
	if (m_wantsOpen)
	{
		m_openBlend = saturate(m_openBlend + 0.7 * Time.deltaTime);

		if (m_openBlend >= 1.0)
		{
			m_moving = false;
		}
	
		instance_deactivate_object(m_collider);
	}
	else
	{
		m_openBlend = saturate(m_openBlend - 2.1 * Time.deltaTime);

		if (m_openBlend <= 0.0)
		{
			m_moving = false;
		}
	
		instance_activate_object(m_collider);
	}
}
else
{
	if (m_queueMoving)
	{
		m_moving = true;
		m_wantsOpen = m_queueWantsOpen;
		m_queueMoving = false;
	}
}