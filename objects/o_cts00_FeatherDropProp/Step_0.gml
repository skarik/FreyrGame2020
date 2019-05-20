/// @description fall to the ground

if (z_height > 0)
{
	z_height -= Time.deltaTime * 20.0;
	x = xstart + sin(current_time * 0.002) * min(z_height * 3.0, 40.0);
	
	image_angle = sin(current_time * 0.0023) * min(z_height * 2.0, 70.0);
}

depthUpdate();