// Force angry off when dead
if (m_isKOed || m_isDead)
{
	m_aiCombat_angry = false;
	m_aiCombat_alerted = false;
}
else
{
	// Do non-combat behavior
	if (!m_aiCombat_angry && !m_aiCombat_alerted)
	{
		if (m_aiNPC_state == kAiNPCGuardState_DefinedGuard)
		{
			if (iexists(m_aiNPC_patrolGuardpoint))
			{
				var dist = point_distance(x, y, m_aiNPC_patrolGuardpoint.x, m_aiNPC_patrolGuardpoint.y);
				if (dist > 10)
				{
					aipathMoveTo(m_aiNPC_patrolGuardpoint.x, m_aiNPC_patrolGuardpoint.y);
					xAxis.value *= m_aiNPC_patrolWalkSpeed;
					yAxis.value *= m_aiNPC_patrolWalkSpeed;
				}
				else
				{
					_controlStructUpdate(xAxis, 0.0);
					_controlStructUpdate(yAxis, 0.0);
				}
				aimotionFaceAtDirection(m_aiNPC_patrolGuardpoint.image_angle, 360);
			}
		}
		else if (m_aiNPC_state == kAiNPCGuardState_DefinedPatrol)
		{
			// Wait in place
			if (m_aiNPC_timer > 0.0)
			{
				m_aiNPC_timer -= Time.deltaTime;
				
				_controlStructUpdate(xAxis, 0.0);
				_controlStructUpdate(yAxis, 0.0);
				
				aimotionFaceAtDirection(m_aiNPC_patrolPathnode.image_angle, 360);
				
				if (m_aiNPC_timer <= 0.0)
				{
					m_aiNPC_patrolPathnode = m_aiNPC_patrolPathnode.m_pathNext;
				}
			}
			// Go to next node
			else
			{
				// Check if the motion can be simplified
				if (m_aiNPC_patrolNextWalkSimple == kTristateUnknown)
				{
					if (!collision3_line(x, y, m_aiNPC_patrolPathnode.x, m_aiNPC_patrolPathnode.y, z, true))
					{
						m_aiNPC_patrolNextWalkSimple = kTristateTrue;
					}
					else
					{
						m_aiNPC_patrolNextWalkSimple = kTristateFalse;
					}
				}
				
				// Move to the patrol target
				if (m_aiNPC_patrolNextWalkSimple == kTristateFalse)
				{
					aipathMoveTo(m_aiNPC_patrolPathnode.x, m_aiNPC_patrolPathnode.y);
					xAxis.value *= m_aiNPC_patrolWalkSpeed;
					yAxis.value *= m_aiNPC_patrolWalkSpeed;
				}
				else
				{
					var control_vector = [m_aiNPC_patrolPathnode.x - x, m_aiNPC_patrolPathnode.y - y];
					var control_vector_len = sqrt(sqr(control_vector[0]) + sqr(control_vector[1]));
					if (control_vector_len > 0.01)
					{
						control_vector[0] /= control_vector_len;
						control_vector[1] /= control_vector_len;
					}
					_controlStructUpdate(xAxis, control_vector[0] * m_aiNPC_patrolWalkSpeed);
					_controlStructUpdate(yAxis, control_vector[1] * m_aiNPC_patrolWalkSpeed);
				}
		
				// If at the patrol point, move to the next point
				if (sqr(x - m_aiNPC_patrolPathnode.x) + sqr(y - m_aiNPC_patrolPathnode.y) < sqr(10))
				{
					if (m_aiNPC_patrolPathnode.m_pathPauseTime > 0.0)
					{	// Pause at it for a time
						m_aiNPC_timer = m_aiNPC_patrolPathnode.m_pathPauseTime;
					}
					else
					{	// Continue going instead
						m_aiNPC_patrolPathnode = m_aiNPC_patrolPathnode.m_pathNext;
					}
					m_aiNPC_patrolNextWalkSimple = kTristateUnknown;
				}				
			}
			// Done.
		}
		else if (m_aiNPC_state == kAiNPCGuardState_Stand)
		{
			_controlStructUpdate(xAxis, 0.0);
			_controlStructUpdate(yAxis, 0.0);
		}
	}
}