m_plantable = false;

var gridSize = 16;

if (!m_isTilling && canMove && !isBusyInteracting)
{
	// Find the piece of land to till:
	var tillX = x + lengthdir_x(12, facingDirection);
	var tillY = y + lengthdir_y(12, facingDirection) + 5;
	tillX = round((tillX - gridSize / 2) / gridSize) * gridSize + gridSize / 2;
	tillY = round((tillY - gridSize / 2) / gridSize) * gridSize + gridSize / 2;

	m_plant_dirt = collision_point(tillX, tillY, o_fieldSquare, false, true);
	if (exists(m_plant_dirt))
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

return m_plantable;