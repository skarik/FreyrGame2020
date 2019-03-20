 
if (!m_isTilling)
{
	// Find the piece of land to till:
	var tillX = x + lengthdir_x(12, facingDirection);
	var tillY = y + lengthdir_y(12, facingDirection) + 5;
	var gridSize = 16;
	tillX = round((tillX + gridSize / 2) / gridSize) * gridSize - gridSize / 2;
	tillY = round((tillY + gridSize / 2) / gridSize) * gridSize - gridSize / 2;

	currentTillable = collision_point(tillX, tillY, o_fieldSquare, false, true);
	if (!exists(currentTillable))
	{
		currentTillable = collision_circle(tillX, tillY, 4, o_fieldSquare, false, true);
		if (!exists(currentTillable))
		{
			currentTillable = null;
		}
	}

	// Check if button is pressed to till the land
	if (exists(currentTillable) && !currentTillable.tilled)
	{
		if (canMove && bButton.pressed)
		{
			m_till_target = currentTillable;
			m_isTilling = true;
			m_till_timer = 0.0;
		}
	}
}
else
{
	currentTillable = m_till_target;
	
	if (exists(m_till_target))
	{
		if (m_till_timer < 1.0)
		{
			m_till_timer += Time.deltaTime / m_till_time;
			
			// Till the land about halfway through the animation
			if (m_till_timer > 0.5)
			{
				currentTillable.tilled = true;
			}
		}
		else
		{
			m_isTilling = false;
			// Force the land to be tilled.
			currentTillable.tilled = true;
		}
	}
	else
	{
		m_isTilling = false;
	}
}