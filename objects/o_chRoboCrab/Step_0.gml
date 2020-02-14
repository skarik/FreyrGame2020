/// @description AI!

//if (live_call()) return live_result;

// force health for testing
stats.m_health = 24.0;
//m_aiCombat_angry = false;

//
// Perform alert checks:

m_aiCombat_updateInterval += Time.deltaTime;
if (m_aiCombat_updateInterval > 0.1) // Update the timer every 0.1 seconds
{
	m_aiCombat_updateInterval -= 0.1;
	
	// In alert mode:
	if (!m_aiCombat_angry)
	{
		// Find a target:
		if (m_aiCombat_target == null)
		{
			// Mark not alerted
			m_aiCombat_alerted = false;
			
			// Find a target:
			var npcCount = instance_number(ob_character);
			for (var i = 0; i < npcCount; ++i)
			{
				var t_npc = instance_find(ob_character, i);
				if (damageCanHit(this, t_npc))
				{
					if (aicommonCanSee(t_npc.x, t_npc.y, max(z, t_npc.z), facingDirection, m_aiCombat_noticeDistance, m_aiCombat_noticeAngle, true))
					{
						m_aiCombat_target = t_npc;
						break;
					}
				}
			}
			// Now have a target
		}
		else
		{
			// Mark alerted
			m_aiCombat_alerted = true;
			
			// Check if target still in range:
			if (exists(m_aiCombat_target))
			{
				var t_npc = m_aiCombat_target;
				
				if (aicommonCanSee(t_npc.x, t_npc.y, max(z, t_npc.z), facingDirection, m_aiCombat_noticeDistance, m_aiCombat_noticeAngle, true))
				{
					// GOOD
				}
				else
				{	// Target is out of range, lose it immediately. TODO: make it track for a little bit.
					m_aiCombat_target = null;
				}
			}
			else
			{
				m_aiCombat_target = null;
			}
			//
		}
	}
	// In angry mode:
	else
	{
		// does target exist?
		if (exists(m_aiCombat_target))
		{
			// update if target visible (wide range)
			if (aicommonCanSee(m_aiCombat_target.x, m_aiCombat_target.y, max(m_aiCombat_target.z, z), facingDirection, 300.0, 360, true))
			{
				m_aiCombat_targetVisible = true;
			}
			else
			{
				m_aiCombat_targetVisible = false;
			}
			
			// update memory if visible
			if (m_aiCombat_targetVisible)
			{
				m_aiCombat_targetPosition = [m_aiCombat_target.x, m_aiCombat_target.y];
			}
		}
		// make immediately not visible if target does not exist.
		else
		{
			m_aiCombat_targetVisible = false;
		}
	}
}

//
// Perform behavior per state:

// Chill
if (!m_aiCombat_angry && !m_aiCombat_alerted)
{	
	// have we gotten to the wander point?
	if (m_aiWander[0] == 0 || aiRobocrabMoveTo(m_aiWander[0], m_aiWander[1]))
	{
		// choose a spot
		m_aiWanderTimer -= Time.deltaTime;
		if (m_aiWanderTimer <= 0.0)
		{
			// do the new wander position
			m_aiWander = [xstart + random_range(-m_aiHomeDistance * 0.7, +m_aiHomeDistance * 0.7),
						  ystart + random_range(-m_aiHomeDistance * 0.7, +m_aiHomeDistance * 0.7)];
			m_aiWanderTimer = 2.0;
		}
	}

	// Freshen up the aggro timer
	m_aiCombat_aggroTimer = 0.0;
}
// Alert
else if (!m_aiCombat_angry && m_aiCombat_alerted)
{
	if (exists(m_aiCombat_target))
	{
		var target_direction	= point_direction(x, y, m_aiCombat_target.x, m_aiCombat_target.y);
		
		// turn towards the direction of the target. No instant snap-to like organics
		facingDirection = turn_towards_direction(facingDirection, target_direction, 180.0 * Time.deltaTime);
		
		// stop moving
		xAxis.value = 0.0;
		yAxis.value = 0.0;
		
		aimingDirection = facingDirection;
		
		// Aggro over a second (or two)
		m_aiCombat_aggroTimer += Time.deltaTime;
		
		// upgrade to angry if in view for 1 second
		if (m_aiCombat_aggroTimer >= 1.0)
		{
			m_aiCombat_angry = true;
		}
	}
}
// Angry
else if (m_aiCombat_angry)
{
	var l_at_rest = false;
	
	// Force the aggro timer up:
	m_aiCombat_aggroTimer += Time.deltaTime * 2.0;
	
	// if target exists and is visible
	if (exists(m_aiCombat_target) && m_aiCombat_targetVisible)
	{
		// move to it, then attack
		if (!isAttacking)
			aiRobocrabMoveTo(m_aiCombat_targetPosition[0], m_aiCombat_targetPosition[1]);
		
		m_aiState_attackTiming += Time.deltaTime;
		
		var tracking_distance = point_distance(x, y, m_aiCombat_targetPosition[0], m_aiCombat_targetPosition[1]);
		if ((true || tracking_distance < 100) && m_aiState_attackTiming > 2.0)
		{
			meleeAtkCurrent = 0; // Force 0.
			if (!isAttacking)
				meleeAtkTimer = max(1.01, meleeAtkTimer);
			_controlStructUpdate(atkButton, 1.0);
			m_aiState_attackTiming = 0.0;
		}
		else
		{
			_controlStructUpdate(atkButton, 0.0); // Release the attack button...
		}
	}
	// if target is not currently tangible
	else
	{
		// if not at last target location, move to last target location
		if (!aiRobocrabMoveTo(m_aiCombat_targetPosition[0], m_aiCombat_targetPosition[1]))
		{	// save a spot to look at
			m_aiWander[0] = m_aiCombat_targetPosition[0];
			m_aiWander[1] = m_aiCombat_targetPosition[1];
		}
		// once there...
		else
		{
			l_at_rest = true;
				
			// spin in place, looking for target.
			m_aiWanderTimer += Time.deltaTime;
			if (m_aiWanderTimer > 1.5)
			{
				m_aiWander[0] = x + random_range(-1, 1);
				m_aiWander[1] = y + random_range(-1, 1);
				m_aiWanderTimer -= 1.5; 
			}
				
			// turn towards the direction of the random target
			var target_direction = point_direction(x, y, m_aiWander[0], m_aiWander[1]);
			facingDirection = turn_towards_direction(facingDirection, target_direction, 180.0 * Time.deltaTime);
			
			aimingDirection = facingDirection;
		}
	}
	
	// if target is not visible & we are at last known position
	if (!m_aiCombat_targetVisible && l_at_rest)
	{
		// deaggro over time
		m_aiCombat_deaggroTimer += Time.deltaTime;
		if (m_aiCombat_deaggroTimer > 5.0)
		{
			m_aiCombat_angry = false;
			m_aiCombat_alerted = true;
			
			m_aiCombat_aggroTimer = 0.0;
			m_aiCombat_deaggroTimer = 0.0;
		}
	}
	// if anything is visible or we're moving, we're still gonna keep aggro up
	else
		m_aiCombat_deaggroTimer = 0.0;
		
}

// Inherit the parent event (does motion)
event_inherited();

// Limit the distance from home.
var kMaxDistance = m_aiHomeDistance * 1.3;
var home_distance = point_distance(x, y, xstart, ystart);
if (home_distance > kMaxDistance)
{
	var rescaled_x = (x - xstart) / home_distance * (kMaxDistance - 0.2);
	var rescaled_y = (y - ystart) / home_distance * (kMaxDistance - 0.2);
	
	x = xstart + rescaled_x;
	y = ystart + rescaled_y;
	
	// Bring any memorized position closer to the bot:
	m_aiWander[0] += (x - m_aiWander[0]) * 0.5;
	m_aiWander[1] += (y - m_aiWander[1]) * 0.5;
	m_aiCombat_targetPosition[0] += (x - m_aiCombat_targetPosition[0]) * 0.5;
	m_aiCombat_targetPosition[1] += (y - m_aiCombat_targetPosition[1]) * 0.5;
}