function _playerInteractCrops(argument0) {
	var l_canMove = argument0;
	var gridSize = 16;

	// default not using a crop
	currentCrop = null;

	// update usable
	/*var kMaxUseDistance = 20.0;
	currentCrop = null;
	var closestDistance = kMaxUseDistance;
	// Get till distance
	var useDistanceAt = max(2.0, min(20.0, point_distance(aimingStartX, aimingStartY, uPosition, vPosition)));
	// Find the piece of land to till:
	var useX = aimingStartX + lengthdir_x(useDistanceAt, aimingDirection);
	var useY = aimingStartY + lengthdir_y(useDistanceAt, aimingDirection);*/
	//var useX = x + lengthdir_x(10, facingDirection);
	//var useY = y + lengthdir_y(10, facingDirection) + 2;

	// Find the piece of land to till:
	var usePosition = _playerInteract_GetAimPosition(1, 2.0, 28.0, 16.0 * 0.5 + 1.0);
	var useX = usePosition[0];
	var useY = usePosition[1];
	//var useDistance = usePosition[2];
	useX = round((useX - gridSize / 2) / gridSize) * gridSize + gridSize / 2;
	useY = round((useY - gridSize / 2) / gridSize) * gridSize + gridSize / 2;

	currentCrop = collision_point(useX, useY, ob_crop, false, true);
	if (!iexists(currentCrop))
	{
		currentCrop = collision_circle(useX, useY, 4, ob_crop, false, true);
		if (!iexists(currentCrop))
		{
			currentCrop = null;
		}
	}

	/*with (ob_crop)
	{
		//var useDistance = point_distance(x, y, useX, useY);
		if (useDistance < 28.0) // TODO: Rework
		{
			other.currentCrop = id;
			closestDistance = useDistance;
		}
	}*/

	if (!m_isHarvesting)
	{
		if (iexists(currentCrop))
		{
			if (l_canMove && !isAttacking && !isDashing && !isBlocking
				&& !m_isTilling && !m_isPlanting
				//&& !iexists(currentUsable) && !iexists(currentHeldUsable) && !iexists(currentCrop) && !m_isHolding
				&& !iexists(currentUsable) && !iexists(currentHeldUsable) && !m_isHolding
				&& useButton.pressed)
			{
				m_harvest_target = currentCrop;
				m_harvest_timer = 0;
				m_isHarvesting = true;
			}
		}
	}
	else
	{
		if (iexists(m_harvest_target) || m_harvest_timer > 0.5)
		{
			// move player to the crop (TODO: Make this temporary, or only affect the visual)
			/*if (iexists(m_harvest_target))
			{
				//x += (m_harvest_target.x - x) * 0.1;
				//y += (m_harvest_target.y - y) * 0.1;
				x = lerp(x, m_harvest_target.x, saturate(m_harvest_timer * 3.0));
				y = lerp(y, m_harvest_target.y, saturate(m_harvest_timer * 3.0));
			}*/
		
			var prev_harvest_time = m_harvest_timer;
			m_harvest_timer += Time.deltaTime / m_harvest_time;
		
			// move the player to the crop - delaying the animation until they're at the point
		
			// harvest at the halfway point
			if (prev_harvest_time < 0.5 && m_harvest_timer >= 0.5)
			{
				// TODO: Play POP sound
			
				// Harvest the crop
				m_harvest_target.m_user = id;
				with (m_harvest_target)
				{
					event_user(0);
				}
			
			}
			if (m_harvest_timer >= 1.0)
			{
				// Done harvesting
				m_isHarvesting = false;
			}
		}
		else
		{
			m_isHarvesting = false;
		}
	}


}
