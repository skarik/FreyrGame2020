var l_canMove = argument0;

currentBuildable = false;

if (!m_isTilling && l_canMove
	&& room == rm_oasis)
{
	// Find the piece of land to till:
	var buildX = aimingStartX + lengthdir_x(12, facingDirection);
	var buildY = aimingStartY + lengthdir_y(12, facingDirection) + 5;
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
	
	// Now we build if we press the button
	if (currentBuildable)
	{
		if (aButton.pressed)
		{
			// Check for existing canal
			if (!exists(collision_rectangle(currentBuildableX + 1, currentBuildableY + 1, currentBuildableX + 14, currentBuildableY + 14, o_miniCanalWater, false, true)))
			{
				// delete any land
				delete(collision_point(currentBuildableX + 8, currentBuildableY + 8, o_fieldSquare, false, true));
				// create canal
				instance_create_depth(currentBuildableX, currentBuildableY, 11, o_miniCanalWater);
			}
		}
	}
}
