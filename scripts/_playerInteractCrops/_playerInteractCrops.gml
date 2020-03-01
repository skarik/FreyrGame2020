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
if (!exists(currentCrop))
{
	currentCrop = collision_circle(useX, useY, 4, ob_crop, false, true);
	if (!exists(currentCrop))
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
	if (exists(currentCrop))
	{
		if (l_canMove && !isAttacking && !isDashing && !isBlocking
			&& !m_isTilling && !m_isPlanting
			&& !exists(currentUsable) && !exists(currentHeldUsable) && !exists(currentCrop) && !m_isHolding
			&& useButton.pressed)
		{
			currentCrop.m_user = id;
			with (currentCrop)
			{
				event_user(0);
			}
		
			m_isHarvesting = true;
		}
	}
}
else
{
	m_isHarvesting = false;
}