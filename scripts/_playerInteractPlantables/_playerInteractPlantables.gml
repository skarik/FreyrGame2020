function _playerInteractPlantables(argument0) {
	var l_canMove = argument0;
	var gridSize = 16;

	m_plantable = false;

	if (!m_isPlanting)
	{
		if (!m_isTilling && canMove && !isBusyInteracting
		    && l_canMove && !isBlocking /*&& !iexists(currentUsable)*/ && !iexists(currentHeldUsable) /*&& !iexists(currentCrop)*/ && !m_isHolding)
		{
			// Find the piece of land to till:
			var tillPosition = _playerInteract_GetAimPosition(1, 2.0, 28.0, 16.0 * 0.5 + 1.0);
			var tillX = tillPosition[0];
			var tillY = tillPosition[1];
			tillX = round((tillX - gridSize / 2) / gridSize) * gridSize + gridSize / 2;
			tillY = round((tillY - gridSize / 2) / gridSize) * gridSize + gridSize / 2;

			m_plant_dirt = collision_point(tillX, tillY, o_fieldSquare, false, true);
			if (iexists(m_plant_dirt))
			{
				m_plant_x = tillX;
				m_plant_y = tillY;
		
				// make sure not tilled or planted
				if (m_plant_dirt.tilled && !m_plant_dirt.planted)
				{
					m_plantable = true;
				}
			}
		}
	}
	else
	{ // Perform the planting animation logic
		if (m_plant_timer < 1.0)
		{
			var previous_timer = m_plant_timer;
	
			m_plant_timer += Time.deltaTime / m_plant_time;
	
			// Do visuals
			if (previous_timer < 2.5/7 && m_till_timer >= 2.5/7)
			{
				effectOnPlantingHit(m_plant_x, m_plant_y);
			}
		}
		else
		{
			m_plant_timer = 0.0;
			m_isPlanting = false;
		}	
	}


}
