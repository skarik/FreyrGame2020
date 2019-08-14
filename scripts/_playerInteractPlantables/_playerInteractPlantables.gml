var l_canMove = argument0;
var gridSize = 16;

m_plantable = false;
//if (!m_isTilling && canMove && !isBusyInteracting)
if (!m_isTilling && canMove && !isBusyInteracting
    && l_canMove && !isBlocking /*&& !exists(currentUsable)*/ && !exists(currentHeldUsable) /*&& !exists(currentCrop)*/ && !m_isHolding)
{
	// Find the piece of land to till:
	var tillPosition = _playerInteract_GetAimPosition(1, 2.0, 28.0, 16.0 * 0.5 + 1.0);
	var tillX = tillPosition[0];
	var tillY = tillPosition[1];
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
