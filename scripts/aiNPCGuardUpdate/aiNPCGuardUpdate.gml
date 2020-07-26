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
					aimotionFaceAtDirection(m_aiNPC_patrolGuardpoint.image_angle, 360);
				}
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
					with (m_aiScript_requestPathnode)
					{
						event_user(kEvent_PathnodeOnPass1);
					}
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
						with (m_aiScript_requestPathnode)
						{
							event_user(kEvent_PathnodeOnPass1);
						}
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
	// Do alert behavior
	else if (!m_aiCombat_angry && m_aiCombat_alerted)
	{
		// Always force patrols to be recalculated when starting
		{
			m_aiNPC_patrolNextWalkSimple = kTristateUnknown;
		}
		
		if (m_aiNPC_alertState == kAiNPCAlertState_Notice)
		{
			if (m_aiNPC_alertTimer == 0.0)
			{
				// Create the ? emote
				var emote_fx = inew(o_fxEmote);
					emote_fx.m_target = id;
					emote_fx.image_index = 1;
			}
			m_aiNPC_alertTimer += Time.deltaTime;
			
			// Face at target position to keep tracking live
			aimotionFaceAt(m_aiCombat_targetPosition[0], m_aiCombat_targetPosition[1], 360);
			
			// Investigate after time
			if (m_aiNPC_alertTimer >= 2.0)
			{
				// If target visible at this point, then we aggro
				if (m_aiCombat_targetVisible)
				{
					// Create the ? emote
					var emote_fx = inew(o_fxEmote);
						emote_fx.m_target = id;
						emote_fx.image_index = 2;
						
					// Force angry now
					m_aiCombat_angry = true;
				}
				// Otherwise we go investigate
				else
				{
					m_aiNPC_alertTimer = 0.0;
					m_aiNPC_alertState = kAiNPCAlertState_Investigate;
				}
			}
		}
		else if (m_aiNPC_alertState == kAiNPCAlertState_Investigate)
		{
			var dist = point_distance(x, y, m_aiNPC_alertPosition[0], m_aiNPC_alertPosition[1]);
			if (dist > 10)
			{
				aipathMoveTo(m_aiNPC_alertPosition[0], m_aiNPC_alertPosition[1]);
				xAxis.value *= m_aiNPC_patrolWalkSpeed;
				yAxis.value *= m_aiNPC_patrolWalkSpeed;
			}
			else
			{
				_controlStructUpdate(xAxis, 0.0);
				_controlStructUpdate(yAxis, 0.0);
				
				// Go to new alert state when at the position
				m_aiNPC_alertState = kAiNPCAlertState_Pause;
				m_aiNPC_alertTimer = 0.0;
			}
		}
		else if (m_aiNPC_alertState == kAiNPCAlertState_Pause)
		{
			if (m_aiNPC_alertTimer == 0.0)
			{
				// Choose a WHAT angle.
				m_aiNPC_alertFacing = random(360);
				
				// Create the ... emote
				var emote_fx = inew(o_fxEmote);
					emote_fx.m_target = id;
					emote_fx.image_index = 0;
			}
			m_aiNPC_alertTimer += Time.deltaTime;
			
			if (m_aiNPC_alertTimer < kAiCombat_DeAlertTime)
			{
				aimotionFaceAtDirection(m_aiNPC_alertFacing, 360);
			}
			else
			{
				// No use being alerted, go back.
				m_aiCombat_alerted = false;
			}
		}
	}
	// Do angry attacking behavior.
	else if (m_aiCombat_angry)
	{
		// Always make sure alert state is reset, so that Notice always triggers on deaggro
		{
			m_aiNPC_alertState = kAiNPCAlertState_Notice;
			m_aiNPC_alertTimer = 0.0;
		}
		
		// If lost track for 5 seconds, go back to not aggro
		if (m_aiCombat_targetTrackingLossTime > kAiCombat_DeAggroTime)
		{
			// Create the ? emote
			var emote_fx = inew(o_fxEmote);
				emote_fx.m_target = id;
				emote_fx.image_index = 1;
				
			m_aiCombat_angry = false;
			m_aiCombat_alerted = true;
			m_aiNPC_alertPosition = m_aiCombat_targetPosition; // Update the alert position
		}
		
		// For now, just have them seek out the player
		var dist = point_distance(x, y, m_aiCombat_targetPosition[0], m_aiCombat_targetPosition[1]);
		if (dist > 20)
		{
			aipathMoveTo(m_aiCombat_targetPosition[0], m_aiCombat_targetPosition[1]);
		}
		else
		{
			_controlStructUpdate(xAxis, 0.0);
			_controlStructUpdate(yAxis, 0.0);
			
			// TOOD: Proper attack. Right now it's insta-death which isn't good
			if (m_aiCombat_targetVisible && iexists(m_aiCombat_target))
			{
				if (m_aiCombat_target.stats.m_health > 0)
				{
					m_aiCombat_target.stats.m_health -= m_aiCombat_target.stats.m_healthMax;
				}
			}
		}
		
	}
	
	if (!m_ai_disableAggression)
	{
		// If not angry, do notice checks
		if (!m_aiCombat_angry)
		{
			aiNPCGuard_UpdateAggroCommon();
			if (iexists(m_aiCombat_target))
			{
				if (m_aiCombat_targetVisible)
				{
					aiNPCGuard_NoticeAt(m_aiCombat_targetPosition[0], m_aiCombat_targetPosition[1]);
				}
			}
		}
		// If angry do combat
		else
		{
			aiNPCGuard_UpdateAggroCommon();
		}
	}
	else
	{
		m_aiCombat_alerted = false;
		m_aiCombat_angry = false;
	}
}