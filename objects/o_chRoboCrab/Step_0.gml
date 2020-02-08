/// @description AI!

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
					// Check if the NPC in vision range
					var target_direction	= point_direction(x, y, t_npc.x, t_npc.y);
					var target_distance		= point_distance(x, y, t_npc.x, t_npc.y);
					
					if (target_distance < m_aiCombat_noticeDistance
						&& abs(angle_difference(facingDirection, target_direction)) < m_aiCombat_noticeAngle)
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
				
				var target_direction	= point_direction(x, y, t_npc.x, t_npc.y);
				var target_distance		= point_distance(x, y, t_npc.x, t_npc.y);
					
				if (target_distance < m_aiCombat_noticeDistance
					&& abs(angle_difference(facingDirection, target_direction)) < m_aiCombat_noticeAngle)
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
	}
}

//
// Perform behavior per state:

// Chill
if (!m_aiCombat_angry && !m_aiCombat_alerted)
{
	// have we gotten to the wander point?
	if (m_aiWander[0] == 0 || point_distance(x, y, m_aiWander[0], m_aiWander[1]) < 6.0)
	{
		// stop moving
		xAxis.value = 0;
		yAxis.value = 0;
		
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
	// move to the wander point
	else
	{
		var target_direction	= point_direction(x, y, m_aiWander[0], m_aiWander[1]);
		var target_distance		= point_distance(x, y, m_aiWander[0], m_aiWander[1]);
		
		// turn towards the direction of the target. No instant snap-to like organics
		facingDirection = turn_towards_direction(facingDirection, target_direction, 180.0 * Time.deltaTime);
		
		// set steering strength based on facing towards target & distance to target.
		var controlSpeed = lerp(1.0,
								0.0,
								saturate(abs(angle_difference(facingDirection, target_direction)) - target_distance / kMoveSpeed * 2.0)
								* saturate(1.0 - target_distance / kMoveSpeed)
								);
		
		xAxis.value = lengthdir_x(controlSpeed, facingDirection);
		yAxis.value = lengthdir_y(controlSpeed, facingDirection);
		
		aimingDirection = facingDirection;
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
	}
}
// Angry
else if (m_aiCombat_angry)
{
	//
}

// Inherit the parent event (does motion)
event_inherited();

