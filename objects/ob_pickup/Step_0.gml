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
	
	// Fall to the ground
	z_height = max(0, z_height - 25.0 * Time.deltaTime * (1.0 - m_pickupCooldown));
	
	var results = ds_list_create();
	var results_count = collision_point_list(x, y, ob_collider, true, true, results, false);
	if (results_count > 0)
	{
		y += 0.5; //Make it slide down the cliff.	
	}
	ds_list_destroy(results);
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
		if (!exists(m_pickupTarget))
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