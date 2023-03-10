function _playerInteractUsables(argument0) {
	var l_canMove = argument0;

	// update usable
	var kMaxUseDistance = 20.0;
	currentUsable = null;
	var closestDistance = kMaxUseDistance;
	if (!iexists(currentHeldUsable) || !m_isHolding)
	{
		// Check if not holding anything
		if (m_isHolding && !iexists(currentHeldUsable))
		{
			currentHeldUsable = null;
			m_isHolding = false;
		
			// enable delay frame
			inDelayFrame = true;
		}
	
		// Get till distance
		var useDistanceAt = max(2.0, min(20.0, point_distance(aimingStartX, aimingStartY, uPosition, vPosition)));
		// Find the piece of land to till:
		var useX = aimingStartX + lengthdir_x(useDistanceAt, aimingDirection);
		var useY = aimingStartY + lengthdir_y(useDistanceAt, aimingDirection);
		//var useX = x + lengthdir_x(10, facingDirection);
		//var useY = y + lengthdir_y(10, facingDirection) + 2;
		with (ob_useable)
		{
			if (!m_usable) continue; // Skip unusable usables.
			//var useDistance = point_distance(x, y, useX, useY);
			var useDistance = distance_to_point(useX, useY);
			if (useDistance < closestDistance)
			{
				other.currentUsable = id;
				closestDistance = useDistance;
			}
		}
	
		if (l_canMove && useButton.pressed)
		{
			if (!iexists(currentUsable))
			{
				//sound_play("audio/ui/use.wav");
			}
			else
			{
				currentUsable.m_user = id;
			
				if (!currentUsable.m_canPickUp)
				{
					with (currentUsable)
					{
						event_user(kEvent_UsableOnUse0);
					}
				}
				else
				{	// Hold it
					currentHeldUsable = currentUsable;
					m_isHolding = true;
					with (currentUsable)
					{
						event_user(kEvent_UsableOnPickup1);
					}
				}
			
				// enable delay frame
				inDelayFrame = true;
			}
		}
	}
	else
	{
		// update usable position
		if (iexists(currentHeldUsable))
		{
			// Move to player position
			currentHeldUsable.x = x;
			currentHeldUsable.y = y;
			currentHeldUsable.z = z;
			currentHeldUsable.z_height = 20 + z_height;
			// Add animation bobs
			var checkAnimIndex = floor(animationIndex % ceil(image_number / 4 - 0.01));
			if (sprite_index == kAnimWalking && (checkAnimIndex == 2 || checkAnimIndex == 5))
			{
				currentHeldUsable.z_height -= 1;
			}
		
			// Behavior for throwing/dropping
			if (canMove && !isBusyInteracting && useButton.pressed)
			{
				if (!currentHeldUsable.m_canThrow
					|| sqr(xspeed) + sqr(yspeed) <= 0.1
					|| sqr(xAxis.value) + sqr(yAxis.value) <= 0.1)
				{
					currentHeldUsable.x = round(x + lengthdir_x(10, aimingDirection));
					currentHeldUsable.y = round(y + lengthdir_y(10, aimingDirection));
					currentHeldUsable.z = z;
					currentHeldUsable.z_height = 0;
					with (currentHeldUsable)
					{
						event_user(kEvent_UsableOnPutdown2);
					}
				}
				else
				{
					currentHeldUsable.x = round(x + lengthdir_x(8, aimingDirection));
					currentHeldUsable.y = round(y + lengthdir_y(8, aimingDirection));
					//currentHeldUsable.z_height = 0;
					with (currentHeldUsable)
					{
						event_user(kEvent_UsableOnThrown3);
					}
				}
				// drop it
				currentHeldUsable = null;
				m_isHolding = false
			
				// enable delay frame
				inDelayFrame = true;
			
				// update usables quickly
				_playerInteractUsables(l_canMove && !inDelayFrame);
			}
			// Behavior for when attacked
			else if (m_isStunned)
			{
				// Drop the object:
				{
					currentHeldUsable.x = round(x + lengthdir_x(10, aimingDirection));
					currentHeldUsable.y = round(y + lengthdir_y(10, aimingDirection));
					currentHeldUsable.z = z;
					currentHeldUsable.z_height = 0;
					with (currentHeldUsable)
					{
						event_user(2);
					}
				}
				// drop it
				currentHeldUsable = null;
				m_isHolding = false
			
				// enable delay frame
				inDelayFrame = true;
			}
		}
		else
		{
			currentHeldUsable = null;
			m_isHolding = false;
		
			// enable delay frame
			inDelayFrame = true;
		
			// update usables quickly
			_playerInteractUsables(l_canMove && !inDelayFrame);
		}
	}



}
