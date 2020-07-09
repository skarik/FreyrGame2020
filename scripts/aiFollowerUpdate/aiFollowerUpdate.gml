if (m_aiFollowing)
{
	var followTarget = o_PlayerTest;
	var followMoved = false;
	if (abs(m_aiFollow_targetX - followTarget.x) > 3 || abs(m_aiFollow_targetY - followTarget.y) > 3)
	{
		m_aiFollow_targetX = followTarget.x;
		m_aiFollow_targetY = followTarget.y;
		followMoved = true;
	}
	var followDistance = point_distance(x, y, m_aiFollow_targetX, m_aiFollow_targetY);
	
	// Check the modes
	var t_inFarmMode = false;
	var t_inCombatMode = false;
	
	if (iexists(followTarget))
	{
		// Check farm state
		if (followTarget.m_isTilling || followTarget.m_isPlanting || iexists(followTarget.currentCrop))
		{
			t_inFarmMode = true;
		}
		else if (followTarget.hud.m_farmoverlay_blend >= 1.0)
		{
			t_inFarmMode = true;
		}
		
		// Add cooldown for farm mode
		if (t_inFarmMode)
		{
			m_aiFollow_farmingCooldown = 5.0;
		}
		else if (!place_meeting(followTarget.x, followTarget.y, ob_areaFarmable))
		{	// Immediately end farm mode if not on farmable area.
			m_aiFollow_farmingCooldown = 0.0;
		}
	}
	if (m_aiFollow_farmingCooldown > 0.0)
	{	
		// Cool down farm mode
		m_aiFollow_farmingCooldown -= Time.deltaTime;
		t_inFarmMode = true;
	}
	
	// Perform state overrides
	if (!t_inFarmMode && !t_inCombatMode)
	{
		// We want to enter the following state if we're in most states
		if (m_aiFollow_state == kAiFollowState_Waiting
			|| m_aiFollow_state == kAiFollowState_Wandering
			|| m_aiFollow_state == kAiFollowState_FarWatch)
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
			|| m_aiFollow_state == kAiFollowState_Following
			|| m_aiFollow_state == kAiFollowState_FarWatch)
		{
			// If we're too close to the follow distance (and the follow target is moving), we want to back off.
			if (followDistance < 12.0 && followMoved)
			{
				m_aiFollow_state = kAiFollowState_BackingOff;
				m_aiFollow_timer = 0.0;
			}
		}
	}
	else if (t_inCombatMode)
	{
	}
	else if (t_inFarmMode)
	{
		if (m_aiFollow_state == kAiFollowState_Waiting
			|| m_aiFollow_state == kAiFollowState_Wandering)
		{
			// Move to out of the way
			m_aiFollow_state = kAiFollowState_FarWatch;
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
			
			// If a talker exists, disable any wandering
			if (ctsGabbersHaveFocus())
			{
				m_aiFollow_timer = 0.0;
			}
			
			// If standing for about 3 seconds, then start wandering
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
				aipathMoveTo(m_aiFollow_targetX, m_aiFollow_targetY);
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
				if (iexists(followTarget))
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
	case kAiFollowState_FarWatch:
		{
			if (m_aiFollow_timer <= 0.01)
			{
				// Choose a watching spot away from the player.
				var followDirection = point_direction(x, y, m_aiFollow_targetX, m_aiFollow_targetY);
			
				// Default backoff is away from follow point at an angle
				var backoff_dir_x = lengthdir_x(1.0, followDirection + 180 + 45);
				var backoff_dir_y = lengthdir_y(1.0, followDirection + 180 + 45);
				
				// Choose the position a bit of ways off.
				m_aiFollow_watchX = m_aiFollow_targetX + backoff_dir_x * 110;
				m_aiFollow_watchY = m_aiFollow_targetY + backoff_dir_y * 110;
			}
			
			// Go to the spot.
			aipathMoveTo(m_aiFollow_watchX, m_aiFollow_watchY);
			// If at the spot, face the player
			if (point_distance(x, y, m_aiFollow_watchX, m_aiFollow_watchY) < 16 && abs(xspeed) < 0.1 && abs(yspeed) < 0.1)
			{
				aimotionFaceAt(m_aiFollow_targetX, m_aiFollow_targetY, 360);
			}
			
			// And just update the follow timer.
			m_aiFollow_timer += Time.deltaTime;
			
			// If player is too close, choose another spot
			if (point_distance(x, y, m_aiFollow_targetX, m_aiFollow_targetY) < 64)
			{
				m_aiFollow_timer = 0.0; // Get a new watch position.
			}
			// If the spot is too far away, follow the player
			if (!point_on_camera_wide(m_aiFollow_watchX, m_aiFollow_watchY, -80, -80))
			{
				m_aiFollow_state = kAiFollowState_Following;
				m_aiFollow_timer = 0.0;
			}
		}
		break;
	}
}
else
{
	// Clear out the motion axes
	_controlStructUpdate(xAxis, 0.0);
	_controlStructUpdate(yAxis, 0.0);
}