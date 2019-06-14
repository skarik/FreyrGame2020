var l_canMove = argument0;
var gridSize = 16;

if (!m_isTilling)
{
	// Get till distance
	var tillDistance = max(2.0, min(28.0, point_distance(aimingStartX, aimingStartY, uPosition, vPosition)));
	// Find the piece of land to till:
	var tillX = aimingStartX + lengthdir_x(tillDistance, aimingDirection);
	var tillY = aimingStartY + lengthdir_y(tillDistance, aimingDirection);
	tillX = round((tillX - gridSize / 2) / gridSize) * gridSize + gridSize / 2;
	tillY = round((tillY - gridSize / 2) / gridSize) * gridSize + gridSize / 2;

	currentTillable = collision_point(tillX, tillY, o_fieldSquare, false, true);
	if (!exists(currentTillable))
	{
		currentTillable = collision_circle(tillX, tillY, 4, o_fieldSquare, false, true);
		if (!exists(currentTillable))
		{
			currentTillable = null;
		}
	}

	// Clear out tillable if busy
	if (exists(currentUsable) || exists(currentHeldUsable) || exists(currentCrop))
	{
		currentTillable = null;
		tillX = 0;
		tillY = 0;
	}
	
	// Clear out tillable if blocked
	if (exists(collision_circle(tillX, tillY, 4, ob_doodadBreakable, false, true)))
	{
		currentTillable = null;
		tillX = 0;
		tillY = 0;
	}

	// Check if button is pressed to till the land
	if (exists(currentTillable))
	{
		if (!currentTillable.tilled)
		{
			if (l_canMove && !isBlocking && !exists(currentUsable) && !exists(currentHeldUsable) && !exists(currentCrop) && !m_isHolding && bButton.pressed)
			{
				m_till_target = currentTillable;
				m_isTilling = true;
				m_till_timer = 0.0;
			}
		}
		// Diable the make dirt power when we're on tillable
		m_till_filldirt = false;
	}
	// If there is no tillable land, we want to fill it with dirt!
	else
	{
		m_till_x = tillX;
		m_till_y = tillY;
		
		if (exists(collision_point(tillX, tillY, ob_areaFarmable, false, true)))
		{
			// Check the four corners of the buildable area for water
			if (!exists(collision_point(tillX + 1 - 8, tillY + 1 - 8, ob_areaWater, true, true))
				&& !exists(collision_point(tillX + 14 - 8, tillY + 1 - 8, ob_areaWater, true, true))
				&& !exists(collision_point(tillX + 1 - 8, tillY + 14 - 8, ob_areaWater, true, true))
				&& !exists(collision_point(tillX + 14 - 8, tillY + 14 - 8, ob_areaWater, true, true)))
			{
				m_till_filldirt = true;
			}
			else
			{
				m_till_filldirt = false;
			}
			
			if (m_till_filldirt)
			{
				// Do we want to make dirt?
				if (l_canMove && !isBlocking && !exists(currentUsable) && !exists(currentHeldUsable) && !exists(currentCrop) && !m_isHolding && bButton.pressed)
				{
					m_till_target = null;
					m_isTilling = true;
					m_till_timer = 0.0;
				}
			}
		}
		else
		{
			m_till_filldirt = false;
		}
	}
	
	// Can we till/fill?
	if (m_till_filldirt)
	{
		m_currentInteractionType = kInteractionTill;
	}
	if (m_till_target != null)
	{
		m_currentInteractionType = kInteractionTill2;
	}
}
// In the tilling loop!
else
{
	currentTillable = m_till_target;
	
	if (exists(m_till_target) || m_till_filldirt)
	{
		if (m_till_timer < 1.0)
		{
			m_till_timer += Time.deltaTime / m_till_time;
			
			// Till the land about halfway through the animation
			if (m_till_timer > 0.5)
			{
				// Till land if tilling
				if (exists(m_till_target))
				{
					currentTillable.tilled = true;
				}
				// Create tillabl land if not tilling
				if (m_till_filldirt)
				{
					if (!exists(collision_point(m_till_x, m_till_y, o_fieldSquare, false, true)))
					{
						// delete any canal
						delete(collision_point(m_till_x + 8, m_till_y + 8, o_miniCanalWater, false, true));
						// create depth
						instance_create_depth(
							m_till_x - gridSize / 2, m_till_y - gridSize / 2,
							49,
							o_fieldSquare);
					}
				}
			}
		}
		else
		{
			m_isTilling = false;
			// Force the land to be tilled.
			if (exists(m_till_target))
			{
				currentTillable.tilled = true;
			}
		}
	}
	else
	{
		m_isTilling = false;
	}
}