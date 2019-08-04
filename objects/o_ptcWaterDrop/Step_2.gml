/// @description update z-stuff

if (z_height <= 0.0)
{
	var splat = instance_create_depth(x, y, 50, o_ptcWaterDropHit);
		splat.image_alpha = 0.99;
		splat.image_angle = choose(0, 1, 2, 3) * 90;
		splat.image_blend = image_blend;
	delete(this);
	exit;
}

depthUpdate();

zprevious = z;
z_heightprevious = z_height;

// Perform motion
zspeed -= 128.0 * Time.deltaTime;
z_height += zspeed * Time.deltaTime;

x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;

z_height = max(0.0, z_height);