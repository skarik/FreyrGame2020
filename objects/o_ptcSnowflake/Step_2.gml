/// @description update z-stuff

if (z_height <= 0.0)
{
	/*var splat = instance_create_depth(x, y, 50, o_ptcWaterDropHit);
		splat.image_alpha = 0.99;
		splat.image_angle = choose(0, 1, 2, 3) * 90;
		splat.image_blend = image_blend;
	delete(this);
	exit;*/
	image_alpha -= Time.deltaTime / 4.0;
	if (image_alpha <= 0.0)
	{
		delete(this);
		exit;
	}
}
else
{
	// Fade in
	image_alpha = min(1.0, image_alpha + Time.deltaTime / 2.0);
	
	// Update positional stuff
	depthUpdate();

	zprevious = z;
	z_heightprevious = z_height;

	// Add gravity
	zspeed -= 8.0 * Time.deltaTime;
	
	// Add wind
	var wind = weatherGetWind();
	xspeed = motion1d_to(xspeed,
						 wind[0] * 0.2 + 30.0 * sin(Time.time * 2.32 + id * 2.321 + x * 0.12 + y * 0.08),
						 20.0 * Time.deltaTime);
	yspeed = motion1d_to(yspeed,
						 wind[1] * 0.2 + 8.0 * sin(Time.time * 3.12 + id * 2.321 + x * 0.09 - y * 0.11),
						 20.0 * Time.deltaTime);

	// Apply motion
	x += xspeed * Time.deltaTime;
	y += yspeed * Time.deltaTime;
	z_height += zspeed * Time.deltaTime;

	// Limit height
	z_height = max(0.0, z_height);
}