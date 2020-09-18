/// @description Update bowl motion

var bowl_count = instance_number(o_doodadWaterBowl);
var pl = getPlayer();

//
// Peturb all bowls
for (var i_bowl = 0; i_bowl < bowl_count; ++i_bowl)
{
	var current_bowl = instance_find(o_doodadWaterBowl, i_bowl);
	if (!current_bowl.visible) continue;
	
	// Add random motion
	current_bowl.xspeed += 16.0 * sin(current_bowl.id * 4.224 + Time.time * 2.5) * Time.deltaTime;
	current_bowl.yspeed += 16.0 * sin(current_bowl.id * 4.457 + Time.time * 2.5) * Time.deltaTime;
	
	// Add positional motion
	current_bowl.xspeed += 48.0 * sin(x / 64.0 + y / 56.0 + Time.time * 0.7) * Time.deltaTime;
	current_bowl.yspeed += 48.0 * sin(x / 48.0 + y / 72.0 + Time.time * 0.8) * Time.deltaTime;
	
	// Push away from player
	var pl_push_dist = 16;
	var pl_dist_sqr = sqr(current_bowl.x - pl.x) + sqr(current_bowl.y - pl.y);
	
	if (pl_dist_sqr < sqr(pl_push_dist))
	{
		var pl_dist = sqrt(pl_dist_sqr);
		var pl_dir = point_direction(current_bowl.x, current_bowl.y, pl.x, pl.y);
		var push = (1.0 - pl_dist / pl_push_dist);
		push *= 64.0 * Time.deltaTime;
		
		current_bowl.xspeed += lengthdir_x(push, pl_dir + 180);
		current_bowl.yspeed += lengthdir_y(push, pl_dir + 180);
	}
}

//
// Check out-of-water collisions
for (var i_bowl = 0; i_bowl < bowl_count; ++i_bowl)
{
	var current_bowl = instance_find(o_doodadWaterBowl, i_bowl);
	if (!current_bowl.visible) continue;
	
	// Not in water?
	if (!areaInWater(current_bowl.x, current_bowl.y, -1024))
	{
		// We need to find the wall
		var normal_x = 0;
		var normal_y = 0;
		var rad2 = current_bowl.radius + 2;
		
		for (var i = 0; i < 360; i += 90)
		{
			var offx = lengthdir_x(1, i);
			var offy = lengthdir_y(1, i);
			
			if (!areaPointInWater(current_bowl.x + offx * rad2, current_bowl.y + offy * rad2, -1024))
			{
				normal_x -= offx;
				normal_y -= offy;
			}
		}
		
		var normal_len = sqrt(sqr(normal_x) + sqr(normal_y));
		if (normal_len <= 0.0)
		{
			// issue
			//debugOut("Bad bowl motion");
			current_bowl.x = current_bowl.xprevious;
			current_bowl.y = current_bowl.yprevious;
		}
		else
		{
			normal_x /= normal_len;
			normal_y /= normal_len;
			
			var normal;
			var in_dir;
			var in_speed;
			var out_dir;
			var restitution = 0.9;
			
			// Use the direction to bowl as normal
			normal = point_direction(0, 0, normal_x, normal_y);
			
			// Now, do bounce motion
			in_speed = point_distance(0, 0, current_bowl.xspeed, current_bowl.yspeed) * restitution;
			in_dir = point_direction(0, 0, current_bowl.xspeed, current_bowl.yspeed);
			out_dir = normal * 2 - in_dir;
			current_bowl.xspeed = lengthdir_x(in_speed, out_dir);
			current_bowl.yspeed = lengthdir_y(in_speed, out_dir);
			
			// Also, we want to push until we're 100% back in the water
			for (var rep = 0; rep < 4 && !areaInWater(current_bowl.x, current_bowl.y, -1024); ++rep)
			{
				current_bowl.x += normal_x;
				current_bowl.y += normal_y;
			}
		}
	}
}

//
// Check inter-bowl collisions
var bowl_collided = array_create(bowl_count, false);
for (var i_bowl = 0; i_bowl < bowl_count; ++i_bowl)
{
	var current_bowl = instance_find(o_doodadWaterBowl, i_bowl);
	if (!current_bowl.visible) continue;
	if (bowl_collided[i_bowl]) continue;
	
	for (var j_bowl = 0; j_bowl < bowl_count; ++j_bowl)
	{
		var target_bowl = instance_find(o_doodadWaterBowl, j_bowl);
		if (!target_bowl.visible) continue;
		
		var dist_sqr = sqr(current_bowl.x - target_bowl.x) + sqr(current_bowl.y - target_bowl.y);
		// Do the bowls collide?
		if (dist_sqr < sqr(current_bowl.radius + target_bowl.radius))
		{
			bowl_collided[j_bowl] = true;
			
			var dx = target_bowl.x - current_bowl.x;
			var dy = target_bowl.y - current_bowl.y;
			var dlen = sqrt(sqr(dx) + sqr(dy));
			var dx_u = dx / dlen;
			var dy_u = dy / dlen;
			var normal;
			var in_dir;
			var in_speed;
			var out_dir;
			var current_projection;
			var target_projection;
			var restitution = 0.9;
			
			// Use the direction to bowl as normal
			normal = point_direction(current_bowl.x, current_bowl.y, target_bowl.x, target_bowl.y);
			
			// First, apply motion of each one to each other, projected onto the normal
			current_projection = max(0.0, current_bowl.xspeed * dx_u + current_bowl.yspeed * dy_u);
			target_projection = max(0.0, target_bowl.xspeed * -dx_u + target_bowl.yspeed * -dy_u);
			
			current_projection /= sqrt(max(0.0001, sqr(current_bowl.xspeed) + sqr(current_bowl.yspeed)));
			target_projection /= sqrt(max(0.0001, sqr(target_bowl.xspeed) + sqr(target_bowl.yspeed)));
			
			current_bowl.xspeed += target_projection * target_bowl.xspeed * (1.0 - restitution);
			current_bowl.yspeed += target_projection * target_bowl.yspeed * (1.0 - restitution);
			
			target_bowl.xspeed += current_projection * current_bowl.xspeed * (1.0 - restitution);
			target_bowl.yspeed += current_projection * current_bowl.yspeed * (1.0 - restitution);
			
			// Now, do bounce motion
			in_speed = point_distance(0, 0, current_bowl.xspeed, current_bowl.yspeed) * restitution;
			in_dir = point_direction(0, 0, current_bowl.xspeed, current_bowl.yspeed);
			out_dir = normal * 2 - in_dir;
			current_bowl.xspeed = lengthdir_x(in_speed, out_dir);
			current_bowl.yspeed = lengthdir_y(in_speed, out_dir);
			
			in_speed = point_distance(0, 0, target_bowl.xspeed, target_bowl.yspeed) * restitution;
			in_dir = point_direction(0, 0, target_bowl.xspeed, target_bowl.yspeed);
			out_dir = normal * 2 - in_dir;
			target_bowl.xspeed = lengthdir_x(in_speed, out_dir);
			target_bowl.yspeed = lengthdir_y(in_speed, out_dir);
			
			// Finally, push away from each other
			var dist = sqrt(dist_sqr);
			var tsize = current_bowl.radius + target_bowl.radius;
			var push = tsize - dist;
			current_bowl.x += lengthdir_x(push * 0.5, normal + 180);
			current_bowl.y += lengthdir_x(push * 0.5, normal + 180);
			target_bowl.x += lengthdir_x(push * 0.5, normal);
			target_bowl.y += lengthdir_x(push * 0.5, normal);
			
			// And a chance to play audio
			if (random(1.0) < 0.001)
			{
				// make sound
				sound_hit = sound_play_at(
					random_range(current_bowl.x - 4, current_bowl.x + 4),
					random_range(current_bowl.y - 4, current_bowl.y + 4),
					choose("audio/phys/hit_bowl1.wav", "audio/phys/hit_bowl2.wav", "audio/phys/hit_bowl3.wav")
					);
				sound_hit.pitch = choose(0.5, 1.0, 1.33);//random_range(0.6, 2.1);
				sound_hit.gain = 0.1 / max(1.0, sound_hit.pitch);
				sound_hit.falloff_start = 40;
				sound_hit.falloff_end = 500;
				sound_hit.falloff_factor = 1;
				sound_hit.parent = current_bowl;
			}
		}
	}
}

//
// Move all bowls
for (var i_bowl = 0; i_bowl < bowl_count; ++i_bowl)
{
	var current_bowl = instance_find(o_doodadWaterBowl, i_bowl);
	if (!current_bowl.visible) continue;
	
	current_bowl.x += current_bowl.xspeed * Time.deltaTime;
	current_bowl.y += current_bowl.yspeed * Time.deltaTime;
}

// 
// Limit all bowl positions
for (var i_bowl = 0; i_bowl < bowl_count; ++i_bowl)
{
	var current_bowl = instance_find(o_doodadWaterBowl, i_bowl);
	if (!current_bowl.visible) continue;
	
	// Push away from player
	var pl_push_dist = 6;
	var pl_dist_sqr = sqr(current_bowl.x - pl.x) + sqr(current_bowl.y - pl.y);
	
	if (pl_dist_sqr < sqr(pl_push_dist))
	{
		var pl_dist = sqrt(pl_dist_sqr);
		var pl_dir = point_direction(current_bowl.x, current_bowl.y, pl.x, pl.y);
		var push = pl_push_dist - pl_dist;
		current_bowl.x += lengthdir_x(push, pl_dir + 180);
		current_bowl.y += lengthdir_y(push, pl_dir + 180);
	}
}