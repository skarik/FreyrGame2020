var patrol_length = array_length_1d(m_aiGobbo_patrol);

// Force angry off if KO or dead
if (m_isKOed || m_isDead)
{
	m_aiCombat_angry = false;
	m_aiCombat_alerted = false;
}
else if (m_aiCombat_enabled)
{
	// Do pushing override
	if (m_aiGobbo_state == kAiGobboPatrolState_OverrideSpawnPush)
	{
		// Move in the direction of the pushes
		_controlStructUpdate(xAxis, lengthdir_x(1.0, facingDirection));
		_controlStructUpdate(yAxis, lengthdir_y(1.0, facingDirection));
		
		m_aiGobbo_timer += Time.deltaTime;
		if (m_aiGobbo_timer > 1.0)
		{
			m_aiGobbo_state = kAiGobboPatrolState_StandCenter;
			m_aiGobbo_timer = 0.0; // Reset state and go to normal behavior
		}
	}
	// Do non-combat behavior
	else if (!m_aiCombat_angry && !m_aiCombat_alerted)
	{
		// Patrolling behavior
		if (patrol_length > 0)
		{
			if (m_aiGobbo_state == kAiGobboPatrolState_StandCenter)
			{
				_controlStructUpdate(xAxis, 0.0);
				_controlStructUpdate(yAxis, 0.0);
	
				m_aiGobbo_timer += Time.deltaTime;
				if (m_aiGobbo_timer > 3.0)
				{
					m_aiGobbo_timer = 0.0;
					m_aiGobbo_state = kAiGobboPatrolState_WalkOut;
					m_aiGobbo_patrolWaypoint = 1;
				}
			}
			// The directions travelled should always be consistent.
			else if (m_aiGobbo_state == kAiGobboPatrolState_StandOut)
			{
				_controlStructUpdate(xAxis, 0.0);
				_controlStructUpdate(yAxis, 0.0);
	
				m_aiGobbo_timer += Time.deltaTime;
				if (m_aiGobbo_timer > 3.0)
				{
					m_aiGobbo_timer = 0.0;
					m_aiGobbo_state = kAiGobboPatrolState_WalkIn;
					m_aiGobbo_patrolWaypoint = patrol_length - 2;
				}
			}
			// Move out to the target
			if (m_aiGobbo_state == kAiGobboPatrolState_WalkOut || m_aiGobbo_state == kAiGobboPatrolState_WalkIn)
			{
				// First face the direction
				if (m_aiGobbo_timer == 0.0)
				{
					// Stand.
				}
				// Stop motion if not been 1 second
				else if (m_aiGobbo_timer < 1.0)
				{
					_controlStructUpdate(xAxis, 0.0);
					_controlStructUpdate(yAxis, 0.0);
			
					var patrol_point = m_aiGobbo_patrol[m_aiGobbo_patrolWaypoint];
					aimotionFaceAt(patrol_point[0], patrol_point[1], 180);
				}
	
				m_aiGobbo_timer += Time.deltaTime;
	
				// If after a second, begin that waypoint follow
				if (m_aiGobbo_timer > 1.0)
				{
					var patrol_point = m_aiGobbo_patrol[m_aiGobbo_patrolWaypoint];
		
					// Move to the patrol target
					aipathMoveTo(patrol_point[0], patrol_point[1]);
		
					// If at the patrol point, move to the next point
					if (sqr(x - patrol_point[0]) + sqr(y - patrol_point[1]) < sqr(16))
					{
						if (m_aiGobbo_state == kAiGobboPatrolState_WalkOut)
						{
							m_aiGobbo_patrolWaypoint += 1;
							if (m_aiGobbo_patrolWaypoint >= patrol_length)
							{
								m_aiGobbo_timer = 0.0;
								m_aiGobbo_state = kAiGobboPatrolState_StandOut;
							}
						}
						else
						{
							m_aiGobbo_patrolWaypoint -= 1;
							if (m_aiGobbo_patrolWaypoint < 0)
							{
								m_aiGobbo_timer = 0.0;
								m_aiGobbo_state = kAiGobboPatrolState_StandCenter;
							}
						}
					}
		
					// Otherwise, we just kinda. Do our thing.
				}
			}
		}
		// Gaurding behavior
		else if (iexists(m_aiGobbo_patrolGuardpoint))
		{
			var dist = point_distance(x, y, m_aiGobbo_patrolGuardpoint.x, m_aiGobbo_patrolGuardpoint.y);
			if (dist > 10)
			{
				aipathMoveTo(m_aiGobbo_patrolGuardpoint.x, m_aiGobbo_patrolGuardpoint.y);
			}
			else
			{
				_controlStructUpdate(xAxis, 0.0);
				_controlStructUpdate(yAxis, 0.0);
			}
			aimotionFaceAtDirection(m_aiGobbo_patrolGuardpoint.image_angle, 360);
		}
		// That's all for the patrol motion.
	}
	// Do alerted behavior
	else if (!m_aiCombat_angry && m_aiCombat_alerted)
	{
		if (true)
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
					// Create the ! emote
					var emote_fx = inew(o_fxEmote);
						emote_fx.m_target = id;
						emote_fx.image_index = 2;
						
					// Force angry now
					m_aiCombat_angry = true;
				}
				// Otherwise we go investigate
				else
				{	// Forget it, we immeidately go back to normal stuff
					m_aiNPC_alertTimer = 0.0;
					m_aiCombat_alerted = false;
					
					// Create the ... emote
					var emote_fx = inew(o_fxEmote);
						emote_fx.m_target = id;
						emote_fx.image_index = 0;
					//m_aiNPC_alertState = kAiNPCAlertState_Investigate;
				}
			}
		}
		
		_controlStructUpdate(xAxis, 0.0);
		_controlStructUpdate(yAxis, 0.0);
	}
	else
	{
		if (m_aiGobbo_angryOverride == null)
		{
			aiGobboSquadAngryUpdate();
		}
		else
		{
			script_execute(m_aiGobbo_angryOverride);
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

	// hacky de-aggro
	m_aiCombat_deaggroTimer -= Time.deltaTime;
	if (m_aiCombat_angry)
	{
		var bTargetExists = iexists(m_aiCombat_target);
		var bForcedDeaggro = false;
		if (bTargetExists)
		{
			// Safe areas need the de-aggro to happen immediately, so that no fights can happen in them.
			// Essential for properly pacing some areas with no-combat zones.
			bForcedDeaggro = aiPointInSafeArea(m_aiCombat_target.x, m_aiCombat_target.y);
		}
		
		if (bForcedDeaggro
			// Target not exists?
			|| !bTargetExists
			// Is target in the grass, hidden, and is far enough away?
			|| (m_aiCombat_target.isHidden && point_distance(x, y, m_aiCombat_target.x, m_aiCombat_target.y) > 48)
			// Too far from the target? 
			|| (point_distance(x, y, m_aiCombat_target.x, m_aiCombat_target.y) > m_aiCombat_combatDistance)
			// Haven't seen the target for a second?
			|| (!m_aiCombat_targetVisible && m_aiCombat_targetTrackingLossTime > 1.0)
			)
		{
			m_aiCombat_deaggroTimer += bTargetExists ? Time.deltaTime : (Time.deltaTime * 3.0);
		
			if (bForcedDeaggro
				|| m_aiCombat_deaggroTimer >= kAiCombat_DeAggroTime // Deaggro after 2 seconds of lost target
				)
			{
				// Create the ? emote
				var emote_fx = inew(o_fxEmote);
					emote_fx.m_target = id;
					emote_fx.image_index = 1;
			
				m_aiCombat_angry = false;
			}
		}
	}
	m_aiCombat_deaggroTimer = clamp(m_aiCombat_deaggroTimer, 0.0, kAiCombat_DeAggroTime);
}