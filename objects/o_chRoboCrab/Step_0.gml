/// @description AI!

if (!m_aiCombat_angry)
{
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
			m_aiWander = [xstart + random_range(-50, +50),
						  ystart + random_range(-50, +50)];
			m_aiWanderTimer = 2.0;
		}
	}
	else
	{
		var target_direction = point_direction(x, y, m_aiWander[0], m_aiWander[1]);
		
		facingDirection = turn_towards_direction(facingDirection, target_direction, 180.0 * Time.deltaTime);
		
		//xspeed = lengthdir_x(kMoveSpeed, facingDirection) * Time.deltaTime;
		//yspeed = lengthdir_y(kMoveSpeed, facingDirection) * Time.deltaTime;
		var controlSpeed = (angle_difference(facingDirection, target_direction) < 10) ? 1.0 : 0.25;
		
		xAxis.value = lengthdir_x(controlSpeed, facingDirection);
		yAxis.value = lengthdir_y(controlSpeed, facingDirection);
		
		aimingDirection = facingDirection;
	}
}

// Inherit the parent event (does motion)
event_inherited();

