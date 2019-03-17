
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
image_index = animationIndex % (image_number / 3);
if (facingAngle == 1 || facingAngle == 3)
	image_index += 2 * image_number / 3;
else if (facingAngle == 2)
	image_index += image_number / 3;
if (facingAngle == 1)
	image_xscale = -1;
else
	image_xscale = +1;

// update facing direction
facingDirection = (facingAngle - 1) * 90;

// update usable
var kMaxUseDistance = 20.0;
currentUsable = null;
var closestDistance = kMaxUseDistance;
var useX = x + lengthdir_x(10, facingDirection);
var useY = y + lengthdir_y(10, facingDirection);
with (ob_useable)
{
	var useDistance = point_distance(x, y, useX, useY);
	if (useDistance < closestDistance)
	{
		other.currentUsable = id;
		closestDistance = useDistance;
	}
}

if (aButton.pressed)
{
	if (!exists(ob_CtsTalker))
	{
		Cts_MakeGabber(id, "Self", "It's a $bpot$$.");
		controlZero(true);
	}
}

