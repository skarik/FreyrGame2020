
// update facing
if (abs(xAxis.value) + abs(yAxis.value) > 0.1)
{
	if (abs(xAxis.value) * 1.1 > abs(yAxis.value))
	{
		facingAngle = (xAxis.value > 0) ? 1 : 3;	
	}
	else
	{
		facingAngle = (yAxis.value > 0) ? 0 : 2;	
	}
}

// update sprite
animationIndex = 0;

// Do different animation depending on the number of images (3 versus 4)
if ((image_number % 3) == 0 && (image_number % 4) != 0)
{
	image_index = animationIndex % (image_number / 3);
	if (facingAngle == 1 || facingAngle == 3)
		image_index += 2 * image_number / 3;
	else if (facingAngle == 2)
		image_index += image_number / 3;
	if (facingAngle == 1)
		image_xscale = -1;
	else
		image_xscale = +1;
}
else if (image_number % 4 == 0)
{
	image_index = animationIndex % (image_number / 4);
	if (facingAngle == 1)
		image_index += 3 * image_number / 4;
	else if (facingAngle == 3)
		image_index += 2 * image_number / 4;
	else if (facingAngle == 2)
		image_index += 1 * image_number / 4;
}

// update facing direction
facingDirection = (facingAngle - 1) * 90;

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
	if (aButton.pressed)
	{
		currentUsable.m_user = id;
		with (currentUsable)
		{
			event_user(0);
		}
		controlZero(true);
	}
}

// tilling controls
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

if (exists(currentTillable))
{
	if (bButton.pressed)
	{
		currentTillable.tilled = true;
	}
}