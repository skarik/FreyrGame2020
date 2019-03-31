var l_canMove = argument0;

// update usable
var kMaxUseDistance = 20.0;
currentUsable = null;
var closestDistance = kMaxUseDistance;
if (!exists(currentHeldUsable) || !m_isHolding)
{
	// Get till distance
	var useDistanceAt = max(2.0, min(20.0, point_distance(x, y, uPosition, vPosition)));
	// Find the piece of land to till:
	var useX = x + lengthdir_x(useDistanceAt, aimingDirection);
	var useY = y + lengthdir_y(useDistanceAt, aimingDirection);
	//var useX = x + lengthdir_x(10, facingDirection);
	//var useY = y + lengthdir_y(10, facingDirection) + 2;
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
		if (l_canMove && bButton.pressed)
		{
			currentUsable.m_user = id;
			
			if (!currentUsable.m_canPickUp)
			{
				with (currentUsable)
				{
					event_user(0);
				}
			}
			else
			{	// Hold it
				currentHeldUsable = currentUsable;
				m_isHolding = true;
				with (currentUsable)
				{
					event_user(1);
				}
			}
			
			// enable delay frame
			inDelayFrame = true;
		}
	}
}
else
{
	// update usable position
	if (exists(currentHeldUsable))
	{
		currentHeldUsable.x = x;
		currentHeldUsable.y = y - 20;
		
		if (canMove && !isBusyInteracting && bButton.pressed)
		{
			if (!currentHeldUsable.m_canThrow)
			{
				currentHeldUsable.x = round(x + lengthdir_x(10, aimingDirection));
				currentHeldUsable.y = round(y + lengthdir_y(10, aimingDirection));
				with (currentHeldUsable)
				{
					event_user(2);
				}
			}
			else
			{
				// TODO: Throw object
				with (currentHeldUsable)
				{
					event_user(3);
				}
			}
			// drop it
			currentHeldUsable = null;
			m_isHolding = false
			
			// enable delay frame
			inDelayFrame = true;
		}
	}
	else
	{
		currentHeldUsable = null;
		m_isHolding = false;
	}
}
