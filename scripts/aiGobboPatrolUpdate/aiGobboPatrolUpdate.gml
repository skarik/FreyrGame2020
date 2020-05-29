var patrol_length = array_length_1d(m_aiGobbo_patrol);

if (!m_aiCombat_angry && !m_aiCombat_alerted)
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
			/*var patrol_point = m_aiGobbo_patrol[m_aiGobbo_patrolWaypoint];
			var patrol_direction = point_direction(x, y, patrol_point[0], patrol_point[1]);
			_controlStructUpdate(xAxis, lengthdir_x(1.0, patrol_direction));
			_controlStructUpdate(yAxis, lengthdir_y(1.0, patrol_direction));*/
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
	// That's all for the patrol motion.
}
else
{
	aiGobboSquadAngryUpdate();
}

// do angry check
var pl = getPlayer();

m_aiCombat_aggroTimer -= Time.deltaTime;

if (!pl.isHidden)
{
	// do distance check
	if (point_distance(x, y, pl.x, pl.y) < m_aiCombat_noticeDistance)
	{
		// do visibility angle check
		var dir = point_direction(x, y, pl.x, pl.y);
		var angle_dif = abs(angle_difference(dir, facingDirection));
		if (angle_dif < m_aiCombat_noticeAngle)
		{
			// do occlusion visibility check
			if (!collision3_line(x, y, pl.x, pl.y, z, true))
			{	
				if (!m_aiCombat_angry)
				{
					if (m_aiCombat_aggroTimer <= 0.0)
					{
						// Create the ? emote
						var emote_fx = inew(o_fxEmote);
							emote_fx.m_target = id;
							emote_fx.image_index = 1;
					}
					
					m_aiCombat_aggroTimer += Time.deltaTime * 2.0;
					
					if (m_aiCombat_aggroTimer > 1.0)
					{
						// Create the ! emote
						var emote_fx = inew(o_fxEmote);
							emote_fx.m_target = id;
							emote_fx.image_index = 2;
			
						m_aiCombat_angry = true;
					}
				}
			}
		}
	}
}
m_aiCombat_aggroTimer = clamp(m_aiCombat_aggroTimer, 0.0, 1.0);

// hacky de-aggro
m_aiCombat_deaggroTimer -= Time.deltaTime;
if (m_aiCombat_angry)
{
	if (
		(pl.isHidden && point_distance(x, y, pl.x, pl.y) > 48)
		|| (point_distance(x, y, pl.x, pl.y) > 212)
		)
	{
		m_aiCombat_deaggroTimer += Time.deltaTime * 2.0;
		
		if (m_aiCombat_deaggroTimer > 1.0)
		{
			// Create the ? emote
			var emote_fx = inew(o_fxEmote);
				emote_fx.m_target = id;
				emote_fx.image_index = 1;
			
			m_aiCombat_angry = false;
		}
	}
}
m_aiCombat_deaggroTimer = clamp(m_aiCombat_deaggroTimer, 0.0, 1.0);