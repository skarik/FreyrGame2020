/// @description Update depth and AI

if (!m_initialized)
	exit;

var pl;
pl = getPlayer();

depthUpdate();

// update AI
if (aiState == kBoidStateIdle)
{
	// If player gets close
	if (sqr(pl.x - x) + sqr(pl.y - y) < sqr(kScareDistance))
	{
		// Fly away
		aiState = kBoidStateFly;
		// Reset fly timer
		aiFlyTimer = 0.0;
		
		// Set inital speed away from player
		var dir = point_direction(pl.x, pl.y, x, y);
		xspeed = lengthdir_x(100, dir);
		yspeed = lengthdir_y(100, dir);
	}
	
	sprite_index = kAnimStanding;
	image_xscale = m_perchFacing;
	animationIndex = 0.0;
}
else if (aiState == kBoidStateFly)
{
	var return_home = false;
	
	// Update fly time
	aiFlyTimer += Time.dt;
	
	// If flying for a while or player is far away, go back to hom
	var sqr_player_dist = sqr(pl.x - m_perchX) + sqr(pl.y - m_perchY);
	if ((aiFlyTimer > 10.0 && sqr_player_dist > sqr(100)) || (sqr_player_dist > sqr(1000)))
	{
		return_home = true;
	}

	
	// Set motion constants
	//var kBoidAcceleration = 1000.0;
	var l_BoidMaxSpeed = kBoidMaxSpeed;
	//var kBoidDirectionAcceleration = 600.0;
	//var kBoidDirectionAccelerationMax = 300.0;
	
	// Do boid motion
	boidDirectionAccel = clamp(boidDirectionAccel + random_range(-kBoidDirectionAcceleration, +kBoidDirectionAcceleration) * Time.deltaTime, -kBoidDirectionAccelerationMax, +kBoidDirectionAccelerationMax);
	boidDirection += boidDirectionAccel * Time.deltaTime;
	// Fix angle for now
	boidDirection = boidDirection mod 360;
	
	// Apply acceleration
	xspeed += lengthdir_x(kBoidAcceleration * (return_home ? 0.1 : 1.0), boidDirection) * Time.deltaTime;
	yspeed += lengthdir_y(kBoidAcceleration * (return_home ? 0.1 : 1.0), boidDirection) * Time.deltaTime;
	
	// Push direction toward other boids
	if (!return_home)
	{
		var boid_count = instance_number(o_chBoid);
		for (var i = 0; i < boid_count; ++i)
		{
			var boid = instance_find(o_chBoid, i);
			if (boid == id) continue;
			if (boid.aiState != kBoidStateFly) continue;
		
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
	}
	
	// Push towards the starting point
	var perch_direction = point_direction(x, y, m_perchX, m_perchY);
	xspeed += lengthdir_x(kBoidAcceleration * (return_home ? 0.2 : 0.5), perch_direction) * Time.deltaTime;
	yspeed += lengthdir_y(kBoidAcceleration * (return_home ? 0.2 : 0.5), perch_direction) * Time.deltaTime;
	
	// Update boid dir
	boidDirection = point_direction(0, 0, xspeed, yspeed);
	
	// Home distance dropper:
	var home_distance = sqr(x - m_perchX) + sqr(y - m_perchY);
	var distance_multiplier = min(1.0, sqrt(home_distance) / (l_BoidMaxSpeed * 1.0));
	
	// Drop max speed if returning home
	if (return_home)
	{
		var high_distance = max(0.2 * distance_multiplier, min(1.0, abs(z_height - m_perchZ_height) / 100.0));
		l_BoidMaxSpeed *= max(high_distance, distance_multiplier);
	}
	
	// Limit the top speed
	var boid_speed = sqrt(sqr(xspeed) + sqr(yspeed));
	xspeed = xspeed * min(l_BoidMaxSpeed / boid_speed, 1.0);
	yspeed = yspeed * min(l_BoidMaxSpeed / boid_speed, 1.0);
	
	// Move bird around
	x += xspeed * Time.deltaTime;
	y += yspeed * Time.deltaTime * 0.8;
	
	// Fly up (or down)
	var target_z_height = 160 + sin(Time.time * 0.5 + id) * 20.0;
	if (return_home)
	{
		// Update the perch height
		if (m_perchProp)
		{
			if (!place_meeting(m_perchX, m_perchY, ob_doodad))
			{
				m_perchProp = false;
				m_perchZ_height = 0.0;
			}
		}
		
		// If we're going thome, need to change height to the target size
		target_z_height = lerp(m_perchZ_height, target_z_height, distance_multiplier);
	}
	z_height = motion1d_to(z_height, target_z_height, 50.0 * Time.deltaTime);
	
	// Update anims
	sprite_index = kAnimFly;
	animationIndex += Time.deltaTime * kAnimSpeedFly;
	
	// Update facing
	image_xscale = sign(xspeed);
	if (image_xscale == 0) image_xscale = 1.0;
	
	// If returning home, we want to stick to the target
	if (return_home)
	{
		if (sqrt(home_distance) < 3.0 && abs(z_height - target_z_height) < 3.0)
		{
			// Land and chiil
			aiState = kBoidStateIdle;
			// Set postion
			x = m_perchX;
			y = m_perchY;
			z = m_perchZ;
			z_height = m_perchZ_height;
		}
	}
}

// Apply animation index
image_index = animationIndex % image_number;