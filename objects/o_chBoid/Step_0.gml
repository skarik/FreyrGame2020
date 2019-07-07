/// @description Update depth and AI

depthUpdate();


// update AI
if (aiState == kBoidStateIdle)
{
	var pl;
	pl = getPlayer();
	
	// If player gets close
	if (sqr(pl.x - x) + sqr(pl.y - y) < sqr(100))
	{
		// Fly away
		aiState = kBoidStateFly;
	}
	
	sprite_index = kAnimStand;
	animationIndex = 0.0;
}
else if (aiState == kBoidStateFly)
{
	// Fly up
	var target_z_height = 160 + sin(current_time / 2000.0 + id) * 20.0;
	z_height = motion1d_to(z_height, target_z_height, 32.0 * Time.deltaTime);
	
	// Set motion constants
	var kBoidAcceleration = 1000.0;
	var kBoidMaxSpeed = 150.0;
	
	// Do boid motion
	boidDirectionAccel = clamp(boidDirectionAccel + random_range(-600, +600) * Time.deltaTime, -300.0, +300.0);
	boidDirection += boidDirectionAccel * Time.deltaTime;
	
	// Apply acceleration
	xspeed += lengthdir_x(kBoidAcceleration, boidDirection) * Time.deltaTime;
	yspeed += lengthdir_y(kBoidAcceleration, boidDirection) * Time.deltaTime;
	
	// Push direction toward other boids
	var boid_count = instance_number(o_chBoid);
	for (var i = 0; i < boid_count; ++i)
	{
		var boid = instance_find(o_chBoid, i);
		if (boid == id) continue;
		
		// Get distance to boid
		var boid_dx = boid.x - x;
		var boid_dy = boid.y - y;
		var boid_distance = sqr(boid_dx) + sqr(boid_dy);
		
		// Grow close if nearby
		if (boid_distance < sqr(400))
		{
			//var boid_dist_sqrt = sqrt(boid_distance);
			xspeed += boid_dx / boid_distance * Time.deltaTime;
			yspeed += boid_dy / boid_distance * Time.deltaTime;
		}
	}
	
	// Push towards the starting point
	var perch_direction = point_direction(x, y, m_perchX, m_perchY);
	xspeed += lengthdir_x(kBoidAcceleration * 0.5, perch_direction) * Time.deltaTime;
	yspeed += lengthdir_y(kBoidAcceleration * 0.5, perch_direction) * Time.deltaTime;
	
	// Update boid dir
	boidDirection = point_direction(0, 0, xspeed, yspeed);
	
	// Limit the top speed
	var boid_speed = sqrt(sqr(xspeed) + sqr(yspeed));
	xspeed = xspeed * min(kBoidMaxSpeed / boid_speed, 1.0);
	yspeed = yspeed * min(kBoidMaxSpeed / boid_speed, 1.0);
	
	// Move bird around
	x += xspeed * Time.deltaTime;
	y += yspeed * Time.deltaTime;
	
	// Update anims
	sprite_index = kAnimFly;
	animationIndex += Time.deltaTime * 20.0;
	
	// Update facing
	image_xscale = sign(xspeed);
	if (image_xscale == 0) image_xscale = 1.0;
}

// Apply animation index
image_index = animationIndex % image_number;