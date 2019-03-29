//
// Angle Update

// update facing
if (!isBusyInteracting && abs(xAxis.value) + abs(yAxis.value) > 0.1)
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

// update facing direction
facingDirection = (facingAngle - 1) * 90;
// override facing direction with the aiming when standing or attacking, and the mouse moves
if (sqr(xspeed) + sqr(yspeed) < 10
    && (uPosition != uPositionPrevious || vPosition != vPositionPrevious))
{
	facingDirection = aimingDirection;
	facingAngle = warpi(round(facingDirection / 90) + 1, 0, 4);
}
/*else
{
	aimingDirection = facingDirection;
}*/

//
// Animation Update

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
