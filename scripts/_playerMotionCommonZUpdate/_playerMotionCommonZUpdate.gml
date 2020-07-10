// Update the elevation if on the ground
if (onGround)
{
	// Check transition
	if (collision3_transition_meeting(x, y))
	{
		 z = collision3_get_highest_meeting(x, y, z);
	}
	// Check stairs
	else
	{
		var found_z = collision3_get_highest_meeting(x, y, z);
		// If step is close enough, automatically move.
		if (abs(z - found_z) < 6)
		{
			// Do y-offset based on horizontal motion
			var verticalMotion = saturate(abs(xspeed / (yspeed + 1.0)) / kMoveSpeed);
			y += verticalMotion * (z - found_z);
			
			// Set new Z now
			z = found_z;
		}
	}
	// Check if we should be falling
	if (z_height > 1.0)
	{
		onGround = false;
	}
	
	time_off_ground = 0.0;
}
else
{
	var z_prev = z;
	
	// Get the floor z
	z = collision3_get_highest_meeting(x, y, z);
	
	// Add to the height if falling
	if (z_ready)
	{
		var y_next = y + (z_prev - z);
		z_height += z_prev - z;
		
		// Check the y_next:
		var z_next = collision3_get_highest_meeting(x, y_next, z);
		if (abs(z_next - z) < 8)
		{
			y = y_next;
		}
		else
		{
			moAnimationYOffset += (z_prev - z);
			//moAnimationYOffsetSpeed = abs(zspeed); // Too slow.
		}
	}
	else
	{
		z_ready = true;
	}
	
	// Perform falling
	zspeed -= Time.deltaTime * 256.0;
	
	// Perform on-ground check
	if (z_height + zspeed * Time.deltaTime < 0)
	{
		// Set on ground
		z_height = 0;
		onGround = true;
		
		// Do on-ground hit
		if (zspeed < 0)
		{
			xspeed = 0.0;
			yspeed = 0.0;
			
			if (abs(zspeed) > 64.0 || time_off_ground > 0.8)
			{
				effectOnGroundHit(x, y);
			}
		}
		
		// Stop motion
		zspeed = 0;
	}
	
	// Perform the actual speed
	z_height += zspeed * Time.deltaTime;
	
	// Count time off ground
	time_off_ground += Time.deltaTime;
}

// Perform the water dumbass hacks
if (inWater)
{
	if (onGround)
	{
		z_height = -4;
	}
}
else
{
	z_height = max(0, z_height);
}
