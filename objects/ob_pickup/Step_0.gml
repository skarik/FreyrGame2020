depthUpdate();

if (!m_isPickingUp)
{
	// Slow down...
	m_pickupSpeedX = max(0.0, abs(m_pickupSpeedX) - Time.deltaTime * kPickupAcceleration * 4.0) * sign(m_pickupSpeedX);
	m_pickupSpeedY = max(0.0, abs(m_pickupSpeedY) - Time.deltaTime * kPickupAcceleration * 4.0) * sign(m_pickupSpeedY);
	
	// Move with speed
	x += m_pickupSpeedX * Time.deltaTime;
	y += m_pickupSpeedY * Time.deltaTime;
	
	// Reset cooldown
	m_pickupCooldown -= Time.deltaTime;
	m_pickupCooldown = saturate(m_pickupCooldown);
	
	//Really fall to the ground
	var z_prev = z;
	z = collision3_get_highest_meeting(x, y, z);
	z_height += z_prev - z;
	
	//Item is falling off of something
	if (z_height > 0.0) {	
		// Fall to the ground
		z_height = max(0, z_height - 25.0 * Time.deltaTime * (1.0 - m_pickupCooldown));
		m_isSliding = true;
	}
	
	//Do sliding logic
	if(m_isSliding == true) {
		//Do the slide
		y += m_slideSpeedY * Time.deltaTime;
	
		//Only calculate the slide velocity 4 timse a second
		if (m_slideTimer < 0.25) {
			m_slideTimer += Time.deltaTime;
		} else {
			m_slideTimer = 0.0;
			m_slideSpeedY = slide_down_cliff(x, y, (z + z_height));
			
			//Item is done sliding, so stop sliding.
			if (m_slideSpeedY == 0.0) {
				m_isSliding = false;
			}
		}
	}
}
else
{
	if (m_pickupTimer < 1.0)
	{
		m_pickupTimer += Time.deltaTime / kPickupTime;
		m_pickupTimer = clamp(m_pickupTimer, 0.0, 1.0);
		
		// Peform some squish effects
		image_yscale = 1.0 + power(saturate(1.0 - m_pickupTimer * 4.0), 2.0) * 0.5;
		image_xscale = 1.0 + power(saturate(1.0 - abs(0.2 - m_pickupTimer) * 4.0), 2.0) * 0.75;
		image_yscale *= 2.0 - image_xscale;
	
		// If no pickup target exists, stop.
		if (!iexists(m_pickupTarget))
		{
			m_pickupTimer = 0.0;
			m_isPickingUp = false;
		}
		else
		{
			// Apply velocity
			var motion_direction = point_direction(x, y, m_pickupTarget.x, m_pickupTarget.y);
			m_pickupSpeedX = lengthdir_x(kPickupAcceleration * Time.deltaTime, motion_direction);
			m_pickupSpeedY = lengthdir_y(kPickupAcceleration * Time.deltaTime, motion_direction);
			
			// Move to the target
			x += m_pickupSpeedX * Time.deltaTime;
			y += m_pickupSpeedY * Time.deltaTime;
			
			// Need to move towards the target's position
			x = lerp(m_pickupStartX, m_pickupTarget.x, power(m_pickupTimer, kPickupCurvePower));
			y = lerp(m_pickupStartY, m_pickupTarget.y - 10, power(m_pickupTimer, kPickupCurvePower));
			
			// Raise off the ground
			z_height = min(18, z_height + 25.0 * Time.deltaTime * (1.0 - m_pickupTimer));
		}
	}
	else
	{
		event_user(0);
	}
}