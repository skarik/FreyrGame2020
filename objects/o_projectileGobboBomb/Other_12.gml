/// @description On Hit World

// Make sure fuse is almost about to blow
m_fuseTimer = min(m_fuseTimer, 1.0);

// Switch to large sprite
sprite_index = s_projectileBombBig;

// Hit the wall? Bounce, but with high slowdown
if (z_height > 0 || m_collisionIsForWall)
{
	// Flip motion by 135 to 225 degrees.
	var dir = point_direction(0, 0, xspeed, yspeed);
	var len = point_distance(0, 0, xspeed, yspeed) * random_range(0.2, 0.4);

	xspeed = lengthdir_x(len, dir + random_range(135, 225));
	yspeed = lengthdir_y(len, dir + random_range(135, 225));
	// If speedy enough to bank up on the wall, do so
	if (len > 10)
		zspeed = len * 0.5;
	zgravity = 800;
}
// Hit ground and stay on ground
else if (abs(zspeed) < 10.0)
{
	var dir = point_direction(0, 0, xspeed, yspeed);
	var len = point_distance(0, 0, xspeed, yspeed);
	// todo: this math can be wildly optimized
	
	len = motion1d_to(len, 0, 1000 * Time.deltaTime);
	xspeed = lengthdir_x(len, dir);
	yspeed = lengthdir_y(len, dir);
	
	if (len <= 0.1)
	{
		m_moving = false;
	}
}
// Bounce off ground
else
{
	zspeed = -zspeed * random_range(0.1, 0.2);
	xspeed *= random_range(0.2, 0.4);
	yspeed *= random_range(0.2, 0.4);
}