/// @description Update motion

particleZMotionUpdate();

// Create smoke particles as we travel
if (!fade)
{
	smoke_timer += Time.deltaTime * 9.0;
	if (smoke_timer > 1.0)
	{
		smoke_timer -= 1.0;
		
		var smoke = instance_create_depth(x, y, depth - 1, o_ptcSmokeFlash);
			smoke.m_flashTimer = 0.01;
			smoke.image_blend = c_orange;
			smoke.image_xscale = 0.6;
			smoke.image_yscale = 0.6;
			smoke.z_height = z_height + 2;
	}
}

if (z_height < 0)
{
	// Begin fading on landing
	if (!fade)
	{
		fade = true;
		
		// Create poof
		var poof = instance_create_depth(x, y - 1, depth - 1, o_ptcDustPoof);
			poof.m_xspeed = xspeed * 0.1;
			poof.m_yspeed = -20.0
			poof.m_friction = 150.0;
			poof.m_life = 0.4;
			poof.m_size = 5.0;
			poof.image_blend = c_gray;
			
		// Turn into fire
		/*var flame =*/ instance_create_depth(x, y, depth - 1, o_ptcFlameGround);
			//flame.z = collision3_get_highest_position(x, y, z_height);
		
		// And we're done
		idelete(this);
		exit;
	}
	
	// Stop motion
	xspeed = 0;
	yspeed = 0;
	zspeed = 0;
	z_height = 0;
}

if (fade)
{
	image_alpha -= Time.deltaTime;
	if (image_alpha < 0.0)
	{
		idelete(this);
	}
}