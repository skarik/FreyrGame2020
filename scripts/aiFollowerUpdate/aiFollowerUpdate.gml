
//if (!exists(ob_CtsTalker))
if (m_aiFollowing)
{
	var followTarget = o_PlayerTest;
	m_aiFollow_targetX = followTarget.x;
	m_aiFollow_targetY = followTarget.y;
	var followDistance = point_distance(x, y, m_aiFollow_targetX, m_aiFollow_targetY);
	
	// We want to enter the following state if we're in most states
	if (m_aiFollow_state == kAiFollowState_Waiting
		|| m_aiFollow_state == kAiFollowState_Wandering)
	{
		// Is the follow target far away? If so, we want to move towards them.
		if (followDistance > kAiFollowBeginDistance)
		{
			m_aiFollow_state = kAiFollowState_Following;
			m_aiFollow_timer = 0.0;
		}
	}
	
	// We want to enter backing off in all states
	if (m_aiFollow_state == kAiFollowState_Waiting
		|| m_aiFollow_state == kAiFollowState_Wandering
		|| m_aiFollow_state == kAiFollowState_Following)
	{
		// If we're too close to the follow distance, we want to back off.
		if (followDistance < 12.0)
		{
			m_aiFollow_state = kAiFollowState_BackingOff;
			m_aiFollow_timer = 0.0;
		}
	}
	
	// Non-overriding states:
	switch (m_aiFollow_state)
	{
	case kAiFollowState_Waiting:
		{
			// Increase the timer - we want to wander at random intervals
			m_aiFollow_timer += Time.deltaTime / 3.0;
			if (m_aiFollow_timer > 1.0)
			{
				m_aiFollow_state = kAiFollowState_Wandering;
			}
			
			// Clear out the motion axes
			_controlStructUpdate(xAxis, 0.0);
			_controlStructUpdate(yAxis, 0.0);
		}
		break;
	case kAiFollowState_Following:
		{
			// We want to move to the player. TODO: pathfinding.
			if (followDistance > kAiFollowCatchupDistance)
			{
				var follow_dir_x = (m_aiFollow_targetX - x) / followDistance;
				var follow_dir_y = (m_aiFollow_targetY - y) / followDistance;

				// Update the motion axes to the given motion
				_controlStructUpdate(xAxis, follow_dir_x);
				_controlStructUpdate(yAxis, follow_dir_y);
			}
			else
			{
				// We caught up, it's time to go back to standing
				m_aiFollow_state = kAiFollowState_Waiting;
				m_aiFollow_timer = 0.0;	
			}
		}
		break
	case kAiFollowState_Wandering:
		{
			// Do we need a new wander point?
			if (m_aiFollow_timer > 1.0)
			{
				// We need to select a new wander target.
				var wander_distance = random_range(20, kAiFollowBeginDistance - 20);
				var wander_direction = random_range(0, 360);
				m_aiFollow_wanderX = m_aiFollow_targetX + lengthdir_x(wander_distance, wander_direction);
				m_aiFollow_wanderY = m_aiFollow_targetY + lengthdir_x(wander_distance, wander_direction);

				// Select a time to stay at that position
				m_aiFollow_wanderStayTime = random_range(1.0, 4.0);

				// Reset the wander timer
				m_aiFollow_timer = 0.0;
			}
			
			var wander_target_distance = point_distance(x, y, m_aiFollow_wanderX, m_aiFollow_wanderY);
			if (wander_target_distance > 8)
			{
				// We want to move towards the wander point
				var wander_target_direction = point_direction(x, y, m_aiFollow_wanderX, m_aiFollow_wanderY);
				var wander_dir_x = lengthdir_x(saturate(wander_target_distance / 16.0), wander_target_direction);
				var wander_dir_y = lengthdir_y(saturate(wander_target_distance / 16.0), wander_target_direction);
				
				// Slow down to walking speed
				wander_dir_x *= 0.5;
				wander_dir_y *= 0.5;
				
				// Update the motion axes to the given motion
				_controlStructUpdate(xAxis, wander_dir_x);
				_controlStructUpdate(yAxis, wander_dir_y);
			}
			else
			{
				m_aiFollow_timer += Time.deltaTime / m_aiFollow_wanderStayTime;
				
				// Clear out the motion axes
				_controlStructUpdate(xAxis, 0.0);
				_controlStructUpdate(yAxis, 0.0);
			}
		}
		break;
	case kAiFollowState_BackingOff:
		{		
			if (m_aiFollow_timer <= 0.01)
			{
				var followDirection = point_direction(x, y, m_aiFollow_targetX, m_aiFollow_targetY);
			
				// Default backoff is away from follow point at an angle
				var backoff_dir_x = lengthdir_x(1.0, followDirection + 180 + 45);
				var backoff_dir_y = lengthdir_y(1.0, followDirection + 180 + 45);
			
				// If our follow target is a moving object, we want to push off based on it's xspeed and yspeed instead
				if (exists(followTarget))
				{
					if (abs(followTarget.xspeed) + abs(followTarget.yspeed) > 0.01)
					{
						// We want to take the dot product against the perpendicular speed to check what to rotate around.
						var cross_product =
							(m_aiFollow_targetX - x) * followTarget.yspeed
							- (m_aiFollow_targetY - y) * followTarget.xspeed;
					
						// Change the motion to be on the right angle
						backoff_dir_x = lengthdir_x(1.0, followDirection + 180 + 80 * sign(cross_product));
						backoff_dir_y = lengthdir_y(1.0, followDirection + 180 + 80 * sign(cross_product));
					}
				}
				
				m_aiFollow_backoffX = backoff_dir_x;
				m_aiFollow_backoffY = backoff_dir_y;
			}
			
			// Update the motion axes to the given motion
			_controlStructUpdate(xAxis, m_aiFollow_backoffX);
			_controlStructUpdate(yAxis, m_aiFollow_backoffY);
		
			// We want to move away from the target for a specific amount of time
			m_aiFollow_timer += Time.deltaTime * 4.0;
		
			// Once we time out, we go back to standing
			if (m_aiFollow_timer > 1.0)
			{
				m_aiFollow_state = kAiFollowState_Waiting;
				m_aiFollow_timer = 0.0;
			}
		}
		break;
	}
}