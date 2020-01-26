/// @description Do scare behavior

depthUpdate();

if (aiState == kFrogStateIdle)
{
	// Just croack
	sprite_index = kAnimStanding;
	animationIndex += Time.deltaTime * kAnimSpeedStanding;
	
	// Hop when player is near
	var pl = getPlayer();
	if (exists(pl) && (sqr(x - pl.x) + sqr(y - pl.y)) < sqr(kScareDistance))
	{
		aiState = kFrogStateHop;
		animationIndex = 0.0;
	}
	
	// Set up Z
	z = collision3_get_highest_position(x, y, z);
}
else if (aiState == kFrogStateHop)
{
	if (xspeed == 0.0 && yspeed == 0.0 && zspeed == 0.0)
	{
		xspeed = sign(image_xscale) * random_range(50, 70);
		yspeed = random_range(-10, +10);
		zspeed = 70.0 - random(10);
		
		aiState = kFrogStateFly;
	}
}
else if (aiState == kFrogStateFly)
{
	// Do motion
	zspeed -= 220.0 * Time.deltaTime;
	
	x += xspeed * Time.deltaTime;
	y += yspeed * Time.deltaTime;
	z_height += zspeed * Time.deltaTime;
	
	// Do animation
	sprite_index = kAnimHopping;
	animationIndex += Time.deltaTime * kAnimSpeedHop;
	
	// Hide in the ground
	if (z_height <= 0.0)
	{
		visible = false;
		aiState += 1;
	}
}

// Apply animation index
image_speed = 0.0;
image_index = animationIndex % image_number;