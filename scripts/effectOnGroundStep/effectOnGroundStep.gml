var tx = argument0;
var ty = argument1;
var tdir = argument2;

var poof, footstep;

// Skip for certain types of NPCs
if (object_index == o_chCaveSlug
	|| object_index == o_chSlimeRed
	|| object_index == o_chBugLunarMoth)
	return;

/*for (var dir = 0; dir < 270; dir += 180)
{
	poof = instance_create_depth(tx, ty, depth - 1, o_ptcDustPoof);
	poof.m_xspeed = lengthdir_x(80.0, dir);
	poof.m_yspeed = lengthdir_y(80.0, dir);
	poof.m_friction = 160.0;
	poof.m_life = 1.0;
	poof.m_size = 16.0;
	poof.image_blend = c_gray;
}*/

if (!areaInWater(x, y))
{
	repeat (3)
	{
		poof = instance_create_depth(tx, ty, depth - 1, o_ptcDustPoof);
		poof.m_direction = random(360);
		poof.m_xspeed = lengthdir_x(20.0, poof.m_direction) + lengthdir_x(20.0, tdir + 180);
		poof.m_yspeed = lengthdir_y(20.0, poof.m_direction) + lengthdir_y(20.0, tdir + 180) - 5.0;
		poof.m_friction = 150.0;
		poof.m_life = 0.4;
		poof.m_size = 6.0;
		poof.image_blend = c_gray;
	}
	
	// make footstep
	footstep = instance_create_depth(tx, ty, depth + 10, o_ptcFootstep);
	footstep.x += random_range(-4, +4);
	footstep.y += random_range(-2, +2);
	footstep.image_angle = tdir;
}