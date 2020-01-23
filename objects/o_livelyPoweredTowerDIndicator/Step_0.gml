/// @description Update depth

depthUpdate();

visual_power = motion1d_to(visual_power, saturate(m_powerOutput), visual_charge_speed * Time.deltaTime);

// Do ambient overcharge logic
if (m_ambientOvercharge && !broken)
{
	overcharge += m_powerOutput * Time.deltaTime * visual_charge_speed * 0.5;
	if (overcharge > 1.2)
	{
		// Mark as broken
		broken = true;
		//overcharge = 0;
		
		image_index += 2; // Move to broken image
		
		// Force power off
		m_powerSource = null;
		m_powerInput = 0;
		
		// Increase speed of visual change
		visual_charge_speed *= 4.0;
		
		// TODO: explosion effect.
	}
}

// Do overcharge vfx
if (overcharge > 0.0)
{
	overcharge_ptc_counter += Time.dt * 40.0 * saturate(overcharge) * visual_power;
	while (overcharge_ptc_counter > 0)
	{
		var ptc = instance_create_depth(x + random_range(-4, 4),
										y + random_range(2, - 16 * 2.5),
										-floor(room_height / 2.0),
										o_ptcMagidustHover);
			ptc.xspeed += random_range(-50, +50) * saturate(overcharge);
			ptc.yspeed += random_range(-10, +10);
			ptc.image_alpha += 0.4;
		overcharge_ptc_counter -= 1.0;
	}
}

// Do broken logic (after overcharge)
if (broken)
{
	// Fade out overcharge effects when broken.
	if (overcharge > 0)
	{
		overcharge = max(0.0, overcharge - Time.deltaTime * 3.0);
	}
}