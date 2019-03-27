// update usable
var kMaxUseDistance = 20.0;
currentUsable = null;
var closestDistance = kMaxUseDistance;
var useX = x + lengthdir_x(10, facingDirection);
var useY = y + lengthdir_y(10, facingDirection) + 2;
with (ob_useable)
{
	var useDistance = point_distance(x, y, useX, useY);
	if (useDistance < closestDistance)
	{
		other.currentUsable = id;
		closestDistance = useDistance;
	}
}

if (exists(currentUsable))
{
	if (canMove && !isBusyInteracting && bButton.pressed)
	{
		currentUsable.m_user = id;
		with (currentUsable)
		{
			event_user(0);
		}
		//controlZero(true);
	}
}
