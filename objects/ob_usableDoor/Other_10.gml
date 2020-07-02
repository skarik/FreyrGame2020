/// @description On use - Open door

if (m_usable && iexists(m_user) && m_user.id == o_PlayerTest.id)
{
	/*if (!iexists(ob_CtsTalker))
	{
		ctsMakeGabber(m_user, "Self", "It's a $b" + m_name + "$$.");
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		inew(o_CtsReenablePlayerOnCtsEnd);
	}*/
	if (m_doorAngleMotion == 0.0)
	{
		m_actionName = ""; // No action until not moving.
		m_doorAngleStart = m_doorAngle;
		
		if (m_doorAngle == 0.0)
		{
			// Get direction to open door:
			if (m_doorOpenMode == kDoorOpenModeOnlyUp)
			{
				m_doorAngleMotion = 1.0;
			}
			else if (m_doorOpenMode == kDoorOpenModeOnlyDown)
			{
				m_doorAngleMotion = -1.0;
			}
			else if (m_doorOpenMode == kDoorOpenModeNormal)
			{
				m_doorAngleMotion = (m_user.y > y) ? 1.0 : -1.0;
			}
	
			m_doorAngleTarget = m_doorAngleMotion * m_doorMaxAngle;
		}
		else
		{
			m_doorAngleMotion = (m_doorAngle > 0.0) ? -1.0 : +1.0;
			m_doorAngleTarget = 0.0;
		}
	}
}