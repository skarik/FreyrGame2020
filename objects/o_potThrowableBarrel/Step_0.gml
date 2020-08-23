/// @description Depth update
depthUpdate();

//if (m_moving)
//{
	// Do gravity accel
	/*zspeed -= zgravity * Time.deltaTime;
	
	// Do ground slide slowdown
	if (m_onGround)
	{
		var xyspeed = avec2_length([xspeed, yspeed]);
		if (xyspeed > 0.0)
		{
			var next_xyspeed = motion1d_to(xyspeed, 0.0, Time.deltaTime * kGroundFriction);
			var next_xyspeed_multiplier = next_xyspeed / xyspeed;
			xspeed *= next_xyspeed_multiplier;
			yspeed *= next_xyspeed_multiplier;
			
			// Do effect now that we're here
			effectOnGroundStep(x, y, point_direction(0, 0, xspeed, yspeed));
		}
	}
	
	// Do velocity
	x += xspeed * Time.deltaTime;
	y += yspeed * Time.deltaTime;
	z_height += zspeed * Time.deltaTime;
	
	if (z_height <= 0.0)
	{
		if (!m_onGround)
		{
			effectOnGroundHit(x, y);
			m_onGround = true;
		}
	}
	else if (z_height > 0.0)
	{
		m_onGround = false;
	}
	
	// Limit ground
	z_height = max(0.0, z_height);
	
	// Stop moving if on ground and no motion
	if (m_onGround && avec2_sqrlength([xspeed, yspeed]) <= 0.0)
	{
		m_moving = false;
		m_usable = true;
	}*/
//}