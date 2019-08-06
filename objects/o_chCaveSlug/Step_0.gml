/// @description Hang around 

if (m_aiState_hangState == 0)
{
	image_alpha = 0.0;
	z_height = 128;
	isPassthru = true;
	
	// Create effects to show where the slug is
	fxtimer_hangdropS += Time.deltaTime * random_range(-5.0, +5.0) * 10.0;
	fxtimer_hangdropS = clamp(fxtimer_hangdropS, 0.1, 3.5);
	fxtimer_hangdrop += Time.deltaTime * fxtimer_hangdropS;
	if (fxtimer_hangdrop > 1.0)
	{
		var rand_dist = random(8);
		var rand_dir = random(360);
		var drop = instance_create_depth(x, y, depth, o_ptcEmissiveWaterDrop);
			drop.x += lengthdir_x(rand_dist, rand_dir);
			drop.y += lengthdir_y(rand_dist, rand_dir);
			drop.z_height = z_height;
			drop.image_blend = c_crystalblue;
			drop.emissive_blend = merge_color(c_crystalblue, c_black, 0.5);
		
		fxtimer_hangdrop -= 1.0;
	}
	
	// Check if a target is close enough
	if (m_aiState_hangStartFall == false)
	{
		var count = instance_number(ob_character);
		for (var i = 0; i < count; ++i)
		{
			var char = instance_find(ob_character, i);
			if (char.id == id)
				continue;
			if ((char.m_team & m_team) != 0)
				continue;
			
			if (sqr(x - char.x) + sqr(y - char.y) < sqr(40.0))
			{
				m_aiState_hangStartFall = true;
				m_aiState_hangStartDelay = random_range(-0.5, 0.8);
			}
		}
	}
	else
	{
		m_aiState_hangStartDelay += Time.deltaTime;
		if (m_aiState_hangStartDelay >= 1.0)
		{
			// Begin fall:
			m_aiState_hangState = 1;
		}
	}
}
else if (m_aiState_hangState == 1)
{
	image_alpha = saturate(image_alpha + Time.deltaTime);
	characterGroundMotionStep();
	
	image_yscale = 1.0 + abs(zspeed) * 0.007;
	
	// Face downwards
	facingDirection = 270;
	aimingDirection = 270;
	
	// Squash on hit ground
	if (z_height <= 0.0)
	{
		if (m_aiState_hangFallblendValue == 0.0)
		{
			m_aiState_hangFallblendStart = image_yscale;
			// Create a ripple effect
			/*var circle = instance_create_depth(x, y, depth + 1, o_ptcCircleHit);
				circle.image_blend = c_crystalblue;
				circle.growSpeed = 40;
				circle.slowAccel = circle.growSpeed;
				circle.fadeSpeed = 1.5;*/
		}
		
		m_aiState_hangFallblendValue += Time.deltaTime * 4.0;
		// Perform proper blend
		image_yscale = lerp(0.8, 1.0, bouncestep(m_aiState_hangFallblendValue));
		image_xscale = lerp(1.5, 1.0, bouncestep(m_aiState_hangFallblendValue));
			
		// Enable AI on the ground
		if (m_aiState_hangFallblendValue >= 1.0)
		{
			image_yscale = 1.0;
			image_xscale = 1.0;
			image_alpha = 1.0;
			m_aiState_hangState = 2;
		}
	}
}
else if (m_aiState_hangState == 2)
{
	// No longer is passthru
	isPassthru = false;
	
	characterGroundMotionStep();
	
	aiSlugUpdate();
}

// Update light
m_light.x = x;
m_light.y = y - z_height;
m_light.image_alpha = 0.5 * image_alpha + 0.5 * m_aiAttackTimer;
m_light2.x = x;
m_light2.y = y - z_height;
if (sqr(m_aiAttackTimer) > m_light2.image_alpha)
	m_light2.image_alpha = sqr(m_aiAttackTimer);
else
	m_light2.image_alpha = saturate(m_light2.image_alpha - Time.deltaTime * 4.0);