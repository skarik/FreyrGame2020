currentBuildable = false;

if (!m_isTilling && canMove && !isBusyInteracting
	&& room == rm_oasis_farm)
{
	// Find the piece of land to till:
	var buildX = x + lengthdir_x(12, facingDirection);
	var buildY = y + lengthdir_y(12, facingDirection) + 5;
	var gridSize = 16;
	buildX = round((buildX - gridSize / 2) / gridSize) * gridSize;
	buildY = round((buildY - gridSize / 2) / gridSize) * gridSize;
	
	// Begin the check...
	var freeSpot = false;
	
	// Check the four corners of the buildable area for water
	if (!exists(collision_point(buildX + 1, buildY + 1, ob_areaWater, true, true))
		|| !exists(collision_point(buildX + 14, buildY + 1, ob_areaWater, true, true))
		|| !exists(collision_point(buildX + 1, buildY + 14, ob_areaWater, true, true))
		|| !exists(collision_point(buildX + 14, buildY + 14, ob_areaWater, true, true)))
	{
		// Check the entire area for colliders
		if (!exists(collision_rectangle(buildX + 1, buildY + 1, buildX + 14, buildY + 14, ob_collider, false, true)))
		{
			freeSpot = true;
		}
	}
	
	// If free of collisions, mark it as buildable!
	if (freeSpot)
	{
		currentBuildable = true;
		currentBuildableX = buildX;
		currentBuildableY = buildY;
	}
}


return currentBuildable;