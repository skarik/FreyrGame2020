/// @description Update motion

if (m_doorAngleMotion != 0.0)
{
	// Decay door angle
	m_doorAngleMotion = max(0.0, abs(m_doorAngleMotion) - Time.deltaTime * 2.0) * sign(m_doorAngleMotion);
	
	// Move the door
	m_doorAngle = lerp(m_doorAngleTarget, m_doorAngleStart, sqr(abs(m_doorAngleMotion)));
	
	// When motion stops, show the prompts again
	if (m_doorAngleMotion == 0.0)
	{
		if (m_doorAngle == 0.0)
		{
			m_actionName = "Open";
		}
		else
		{
			m_actionName = "Close";
		}
	}
}