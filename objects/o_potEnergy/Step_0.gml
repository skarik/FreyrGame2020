/// @description Depth update

depthUpdate();

// Handle light
m_light.x = x;
m_light.y = y;
m_light.image_alpha = saturate(energyPower + (random(0.2) - 0.1));

// Apply overcharging effects:
if (overcharge > 0.0)
{
	overcharge_ptc_counter += Time.dt * 30.0 * overcharge * energyPower;
	while (overcharge_ptc_counter > 0)
	{
		var ptc = instance_create_depth(x + random_range(-4, 4),
										y + random_range(-4, 4) - z_height,
										-floor(room_height / 2.0),
										o_ptcMagidustHover);
			ptc.xspeed += random_range(-30, +30) * (overcharge + 0.25);
			ptc.yspeed += random_range(-30, +30);
			ptc.image_alpha += 0.4;
		overcharge_ptc_counter -= 1.0;
	}
	
	// If overcharged a little bit, end self.
	if (overcharge > 1.0)
	{
		energyFade = true;
	}
}

// Fading in and out:
if (!energyFade)
{	// Blend the power in if we're not fading.
	energyPower = min(1.0, energyPower + Time.deltaTime);
}
else
{	// If we're fading, blend power out then destroy.
	energyPower -= Time.deltaTime * 0.5;
	if (energyPower <= 0.0)
	{
		idelete(this);
	}
}
