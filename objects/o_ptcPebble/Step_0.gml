/// @description Update motion

particleZMotionUpdate();

if (z_height < 0)
{
	// Begin fading on landing
	if (!fade)
	{
		fade = true;
		
		// Create poof
		var poof;
		poof = instance_create_depth(x, y - 1, depth - 1, o_ptcDustPoof);
		poof.m_xspeed = xspeed * 0.1;
		poof.m_yspeed = -20.0
		poof.m_friction = 150.0;
		poof.m_life = 0.4;
		poof.m_size = 5.0;
		poof.image_blend = c_gray;
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
		delete(this);
	}
}