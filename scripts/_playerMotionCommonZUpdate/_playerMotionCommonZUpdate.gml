// Update the elevation if on the ground
if (onGround)
{
	if (place_meeting(x, y, ob_elevationBlendArea))
	{
		 z = collision3_get_highest_meeting(x, y, z);
	}
	// Check if we should be falling
	if (z_height > 1.0)
	{
		onGround = false;
	}
}
else
{
	var z_prev = z;
	
	// Get the floor z
	z = collision3_get_highest_meeting(x, y, z);
	
	// Add to the height if falling
	//if (z_prev > z)
	{
		y += z_prev - z;
		z_height += z_prev - z;
	}
	
	// Perform falling
	zspeed -= Time.deltaTime * 256.0;
	
	// Perform on-ground check
	if (z_height + zspeed * Time.deltaTime < 0)
	{
		zspeed = 0;
		z_height = 0;
		onGround = true;
	}
	
	// Perform the actual speed
	z_height += zspeed * Time.deltaTime;
}