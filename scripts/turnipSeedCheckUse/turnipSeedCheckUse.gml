/*m_plantable = false;

var gridSize = 16;

if (!m_isTilling && canMove && !isBusyInteracting)
{
	// Get till distance
	var tillDistance = max(2.0, min(28.0, point_distance(aimingStartX, aimingStartY, uPosition, vPosition)));
	// Find the piece of land to till:
	var tillX = aimingStartX + lengthdir_x(tillDistance, aimingDirection);
	var tillY = aimingStartY + lengthdir_y(tillDistance, aimingDirection);
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

return m_plantable;*/

_playerInteractPlantables(true);
return m_plantable;