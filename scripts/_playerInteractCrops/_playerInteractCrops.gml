// update usable
var kMaxUseDistance = 20.0;
currentCrop = null;
var closestDistance = kMaxUseDistance;
// Get till distance
var useDistanceAt = max(2.0, min(20.0, point_distance(x, y, uPosition, vPosition)));
// Find the piece of land to till:
var useX = x + lengthdir_x(useDistanceAt, aimingDirection);
var useY = y + lengthdir_y(useDistanceAt, aimingDirection);
//var useX = x + lengthdir_x(10, facingDirection);
//var useY = y + lengthdir_y(10, facingDirection) + 2;
with (ob_crop)
{
	var useDistance = point_distance(x, y, useX, useY);
	if (useDistance < closestDistance)
	{
		other.currentCrop = id;
		closestDistance = useDistance;
	}
}

if (exists(currentCrop))
{
	if (canMove && !isBusyInteracting && bButton.pressed)
	{
		currentCrop.m_user = id;
		with (currentCrop)
		{
			event_user(0);
		}
	}
}
