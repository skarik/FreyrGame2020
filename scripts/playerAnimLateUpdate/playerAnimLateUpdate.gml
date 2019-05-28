//
// Angle Update

// update facing
if (!isBusyInteracting && abs(xAxis.value) + abs(yAxis.value) > 0.1)
{
	if (abs(xAxis.value) * 1.1 > abs(yAxis.value))
	{
		facingIndex = (xAxis.value > 0) ? 1 : 3;	
	}
	else
	{
		facingIndex = (yAxis.value > 0) ? 0 : 2;	
	}
}

// update facing direction
//facingDirection = (facingIndex - 1) * 90;
if (!isBusyInteracting && abs(xAxis.value) + abs(yAxis.value) > 0.1)
{
	facingDirection = point_direction(0, 0, xAxis.value, yAxis.value);
}
// override facing direction with the aiming when standing or attacking, and the mouse moves
if (sqr(xspeed) + sqr(yspeed) < 10
    && (uPosition != uPositionPrevious || vPosition != vPositionPrevious))
{
	facingDirection = aimingDirection;
}
/*else
{
	aimingDirection = facingDirection;
}*/
// always update the facing direction, though
facingIndex = warpi(round(facingDirection / 90) + 1, 0, 4);

//
// Animation Select
if (!moAnimationPlayback)
{
	if (isDashing)
	{
		sprite_index = kAnimRolling;
		animationSpeed = 0.0;
		animationIndex = floor((image_number / 4.0 - 0.01) * saturate(dashTimer / kDashTime));
	}
	else
	{
		var move_speed = sqrt(sqr(xspeed) + sqr(yspeed));
		if (move_speed < 3.0)
		{
			sprite_index = kAnimStanding;
			//animationIndex = 0.0;
			animationSpeed = 0.0;
		}
		else
		{
			sprite_index = kAnimWalking;
			animationSpeed = 14.0          // Start with 12 to 14 FPS
				* move_speed / kMoveSpeed  // Base it on the movespeed
				* (image_number / 24.0);   // Scale up for more frames in the walk animation, assuming 12 FPS 6-cycle
		}
	}
}
else
{
	// set animation playback externally
}

//
// Animation Update

// update sprite
animationIndex += animationSpeed * Time.deltaTime;

// Do different animation depending on the number of images (3 versus 4)
if (!moAnimationPlayback)
{
	if ((image_number % 3) == 0 && (image_number % 4) != 0)
	{
		image_index = animationIndex % (image_number / 3);
		if (facingIndex == 1 || facingIndex == 3)
			image_index += 2 * image_number / 3;
		else if (facingIndex == 2)
			image_index += image_number / 3;
		if (facingIndex == 1)
			image_xscale = -1;
		else
			image_xscale = +1;
	}
	else if (image_number % 4 == 0)
	{
		// 0 - 270, 1 - 0, 2 - 90, 3 - 180
		image_index = animationIndex % (image_number / 4);
		if (facingIndex == 1)
			image_index += 3 * image_number / 4;
		else if (facingIndex == 3)
			image_index += 2 * image_number / 4;
		else if (facingIndex == 2)
			image_index += 1 * image_number / 4;
	}
}
else
{
	if (moAnimationPlaybackLooped)
	{
		image_index = animationIndex % image_number;
	}
	else
	{
		image_index = clamp(animationIndex, 0.0, image_number - 1.0);
	}
}
