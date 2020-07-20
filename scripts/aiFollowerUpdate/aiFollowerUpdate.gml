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
	var t_inStealthMode = false;
	var t_inPrivacyMode = false;
	
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
		
		// Check combat state
		var t_notifyArea = collision_point(followTarget.x, followTarget.y, ob_areaAINotify, false, true);
		if (m_tookDamage
			|| array_length_1d(followTarget.m_dealtDamageListAggregate) > 0
			|| (iexists(t_notifyArea) && t_notifyArea.m_aiAngry)) // TODO: improve this. areas dont deaggro properly right now
		{
			t_inCombatMode = true;
		}
		// Add cooldown for combat mode
		if (t_inCombatMode)
		{
			m_aiFollow_combatCooldown = 2.0;
		}
		else if (aiPointInSafeArea(m_aiFollow_targetX, m_aiFollow_targetY))
		{
			m_aiFollow_combatCooldown = 0.0;
		}
		
		// Check stealth state
		if (followTarget.isHidden)
		{
			t_inStealthMode = true;
		}
		
		// Check privacy mode
		if (aiPointInPrivacyArea(m_aiFollow_targetX, m_aiFollow_targetY))
		{
			t_inPrivacyMode = true;
		}
	}
	if (m_aiFollow_farmingCooldown > 0.0)
	{	
		// Cool down farm mode
		m_aiFollow_farmingCooldown -= Time.deltaTime;
		t_inFarmMode = true;
	}
	if (m_aiFollow_combatCooldown > 0.0)
	{
		// Cool down combat mode
		m_aiFollow_combatCooldown -= Time.deltaTime;
		t_inCombatMode = true;
	}
	
	
	// Perform state overrides
	if (!t_inFarmMode && !t_inCombatMode && !t_inStealthMode && !t_inPrivacyMode)
	{
		// We want to enter the following state if we're in most states
		if (m_aiFollow_state == kAiFollowState_Waiting
			|| m_aiFollow_state == kAiFollowState_Wandering
			|| m_aiFollow_state == kAiFollowState_FarWatch
			|| m_aiFollow_state == kAiFollowState_AvoidAndSeekHidePoints)
		{
			// Is the follow target far away? If so, we want to move towards them.
			if (followDistance > kAiFollowBeginDistance)
			{
				m_aiFollow_state = kAiFollowState_Following;
				m_aiFollow_timer = 0.0;
			}
		}
		
		// We want to enter the following state with more restrictions
		if (m_aiFollow_state == kAiFollowState_Gawking)
		{
			if (point_distance(m_aiFollow_gawk_starttargetX, m_aiFollow_gawk_starttargetY, followTarget.x, followTarget.y) > kAiFollowBeginDistanceWhenGawking)
			{
				m_aiFollow_state = kAiFollowState_Following;
				m_aiFollow_timer = 0.0;
			}
		}
		
		// We want to enter backing off in all states
		if (m_aiFollow_state == kAiFollowState_Waiting
			|| m_aiFollow_state == kAiFollowState_Wandering
			|| m_aiFollow_state == kAiFollowState_Following
			|| m_aiFollow_state == kAiFollowState_FarWatch
			|| m_aiFollow_state == kAiFollowState_AvoidAndSeekHidePoints)
		{
			// If we're too close to the follow distance (and the follow target is moving), we want to back off.
			if (followDistance < 12.0)
			{
				m_aiFollow_state = kAiFollowState_BackingOff;
				m_aiFollow_timer = 0.0;
			}
		}
	}
	else if (t_inCombatMode && kAiFollowHideDuringCombat)
	{
		// Check for too close first
		m_aiFollow_cachedAvoidCharacter = instance_nearest_notme(x, y, ob_characterGround);
		if (m_aiFollow_cachedAvoidCharacter.isAttacking || damageCanHit(m_aiFollow_cachedAvoidCharacter, id))
		{
			if (m_aiFollow_state == kAiFollowState_Waiting
				|| m_aiFollow_state == kAiFollowState_Wandering
				|| m_aiFollow_state == kAiFollowState_Following
				|| m_aiFollow_state == kAiFollowState_FarWatch)
			{
				m_aiFollow_state = kAiFollowState_AvoidAllCharacters;
				m_aiFollow_timer = 0.0;
			}
		}
		// Override all other behavior with hiding
		if (m_aiFollow_state == kAiFollowState_Waiting
			|| m_aiFollow_state == kAiFollowState_Wandering
			|| m_aiFollow_state == kAiFollowState_Following
			|| m_aiFollow_state == kAiFollowState_FarWatch)
		{
			m_aiFollow_state = kAiFollowState_AvoidAndSeekHidePoints;
			m_aiFollow_timer = 0.0;
		}
	}
	else if (t_inCombatMode && !kAiFollowHideDuringCombat)
	{
		// Back away from the player
	}
	else if (t_inStealthMode)
	{
		// We want to enter the following state if we're in most states
		if (m_aiFollow_state != kAiFollowState_BackingOff)
		{
			// Is the follow target far away? If so, we want to move towards them.
			if (m_aiFollow_state == kAiFollowState_Wandering
				|| followDistance > kAiFollowHiddenDistance)
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
	else if (t_inPrivacyMode)
	{
		// We want to force gawking
		if (m_aiFollow_state != kAiFollowState_Gawking)
		{
			m_aiFollow_state = kAiFollowState_Wandering;
			m_aiFollow_timer = 2.0;
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
			// We want to move to the player.
			if (followDistance > (t_inStealthMode ? kAiFollowHiddenDistance : kAiFollowCatchupDistance))
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
				
				// Find a random position nearby, and maybe gawk at that instead
				var t_validGawkpoints = [null];
				var t_gawkpointCount = instance_number(o_aiGawkPoint);
				for (var i = 0; i < t_gawkpointCount; ++i)
				{
					var t_gawkpoint = instance_find(o_aiGawkPoint, i);
					if (sqr(t_gawkpoint.x - x) + sqr(t_gawkpoint.y - y) < sqr(kAiFollowGawkSearchDistance))
					{
						if (!array_contains(m_aiFollow_gawksBurnt, t_gawkpoint))
						{
							t_validGawkpoints[array_length_1d(t_validGawkpoints)] = t_gawkpoint;
						}
					}
				}
				var t_gawkchoiceIndex = floor(random(array_length_1d(t_validGawkpoints)));
				var t_gawkchoice = t_validGawkpoints[t_gawkchoiceIndex];
				if (t_gawkchoice != null)
				{
					debugOut("Entering gawk mode");
					// Let's do some gawking instead of wandering.
					m_aiFollow_gawk_starttargetX = m_aiFollow_targetX;
					m_aiFollow_gawk_starttargetY = m_aiFollow_targetY;
					m_aiFollow_gawkPoint = t_gawkchoice;
					m_aiFollow_gawkTriggered = false;
					m_aiFollow_gawkStayTime = random_range(8.0, 18.0);
					m_aiFollow_state = kAiFollowState_Gawking;
				}
				else
				{
					// If no gawkpoints available, clear the burnt gawks
					if (array_length_1d(t_validGawkpoints) == 1)
					{
						m_aiFollow_gawksBurnt = [];
					}
				}
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
	case kAiFollowState_Gawking:
		{
			if (m_aiFollow_timer > 1.0)
			{
				// Go back to wandering (which could trigger gawking again lol)
				m_aiFollow_state = kAiFollowState_Wandering;
			}
			
			var gawk_target_distance = point_distance(x, y, m_aiFollow_gawkPoint.x, m_aiFollow_gawkPoint.y);
			if (gawk_target_distance > 8)
			{
				aipathMoveTo(m_aiFollow_gawkPoint.x, m_aiFollow_gawkPoint.y);
				
				// We want to move towards the wander point
				/*var gawk_target_direction = point_direction(x, y, m_aiFollow_gawkPoint.x, m_aiFollow_gawkPoint.y);
				var gawk_dir_x = lengthdir_x(saturate(gawk_target_distance / 16.0), gawk_target_direction);
				var gawk_dir_y = lengthdir_y(saturate(gawk_target_distance / 16.0), gawk_target_direction);
				
				// Slow down to walking speed
				gawk_dir_x *= 0.5;
				gawk_dir_y *= 0.5;
				
				// Update the motion axes to the given motion
				_controlStructUpdate(xAxis, gawk_dir_x);
				_controlStructUpdate(yAxis, gawk_dir_y);*/
			}
			else
			{
				m_aiFollow_timer += Time.deltaTime / m_aiFollow_gawkStayTime;
				
				if (!m_aiFollow_gawkTriggered)
				{
					if (!ctsGabbersHaveFocus())
					{	// Only add burn points if not talking with someone.
						with (m_aiFollow_gawkPoint)
						{
							event_user(kEvent_DefaultTrigger0);
						}
						m_aiFollow_gawkTriggered = true;
						m_aiFollow_gawksBurnt[array_length_1d(m_aiFollow_gawksBurnt)] = m_aiFollow_gawkPoint;
					}
				}
				
				// Face the gawk angle
				aimotionFaceAtDirection(m_aiFollow_gawkPoint.image_angle, 360);
				
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
	case kAiFollowState_AvoidAllCharacters:
		{
			// Back away from the nearest char
			if (!iexists(m_aiFollow_cachedAvoidCharacter))
			{
				m_aiFollow_cachedAvoidCharacter = instance_nearest_notme(x, y, ob_characterGround);
			}
		
			var t_doneAvoiding = false;
			if (iexists(m_aiFollow_cachedAvoidCharacter))
			{
				var t_vectorFrom = [x - m_aiFollow_cachedAvoidCharacter.x, y - m_aiFollow_cachedAvoidCharacter.y];
				var t_vectorFromLen = sqrt(sqr(t_vectorFrom[0]) + sqr(t_vectorFrom[1]));
			
				t_vectorFrom[0] /= t_vectorFromLen;
				t_vectorFrom[1] /= t_vectorFromLen;
			
				if (t_vectorFromLen < 80)
				{
					_controlStructUpdate(xAxis, t_vectorFrom[0]);
					_controlStructUpdate(yAxis, t_vectorFrom[1]);
				}
				else
				{	// Far enough away, we can stop.
					_controlStructUpdate(xAxis, 0.0);
					_controlStructUpdate(yAxis, 0.0);
					
					t_doneAvoiding = true;
				}
			}
			else
			{
				t_doneAvoiding = true;
			}
			
			if (t_doneAvoiding)
			{
				m_aiFollow_timer += Time.deltaTime * 2.0;
				if (m_aiFollow_timer > 1.0)
				{
					m_aiFollow_state = kAiFollowState_Following;
					m_aiFollow_timer = 0.0;
				}
			}
		}
		break;
	case kAiFollowState_AvoidAndSeekHidePoints:
		{
			if (m_aiFollow_hidePoint == null || !iexists(m_aiFollow_hidePoint))
			{
				// Find a hide spot nearby
				var t_nearestHidePoint = null;
				var t_nearestHidePointSqrDist = sqr(kAiFollowHideSearchDistance);
			
				var t_hidepointCount = instance_number(o_aiHidePoint);
				for (var i = 0; i < t_hidepointCount; ++i)
				{
					var t_hidepoint = instance_find(o_aiHidePoint, i);
					var t_dist = sqr(x - t_hidepoint.x) + sqr(y - t_hidepoint.y);
				
					if (t_dist < t_nearestHidePointSqrDist)
					{
						if (!array_contains(m_aiFollow_hidePointsBurnt, t_hidepoint))
						{
							t_nearestHidePoint = t_hidepoint;
							t_nearestHidePointSqrDist = t_dist;
						}
					}
				}
			
				// Go to the hidespot
				if (t_nearestHidePoint != null)
				{
					m_aiFollow_hidePoint = t_nearestHidePoint;
				}
				
				// If no points found, go to avoid state and reset burn list
				if (t_nearestHidePoint == null)
				{
					m_aiFollow_hidePointsBurnt = [];
					m_aiFollow_state = kAiFollowState_AvoidAllCharacters;
					m_aiFollow_timer = 0.0;
				}
			}
			else
			{
				// Go to the spot.
				aipathMoveTo(m_aiFollow_hidePoint.x, m_aiFollow_hidePoint.y);
				// If at the spot, face the player
				if (point_distance(x, y, m_aiFollow_hidePoint.x, m_aiFollow_hidePoint.y) < 10 && abs(xspeed) < 0.1 && abs(yspeed) < 0.1)
				{
					aimotionFaceAtDirection(m_aiFollow_hidePoint.image_angle, 360);
				}
				
				// If hide spot compromised, find a new hide spot
				if (m_tookDamage ||
					(iexists(m_aiFollow_cachedAvoidCharacter)
					&& damageCanHit(m_aiFollow_cachedAvoidCharacter, id)
					&& point_distance(x, y, m_aiFollow_cachedAvoidCharacter.x, m_aiFollow_cachedAvoidCharacter.y) < 20))
				{
					m_aiFollow_hidePointsBurnt[array_length_1d(m_aiFollow_hidePointsBurnt)] = m_aiFollow_hidePoint;
					m_aiFollow_hidePoint = null;
				}
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