var tx = argument0;
var ty = argument1;
var tdir = argument2;

var poof, footstep, fader;

// Skip for certain types of NPCs
if (object_index == o_chCaveSlug
	|| object_index == o_chSlimeRed
	|| object_index == o_chBugLunarMoth)
	return;

//
// Select the proper material
var ground_material = 0;
if (!areaInWater(x, y))
{
	ground_material = vtileGetMaterialAtPosition(x, y);	
}
else
{
	ground_material = kTileMaterial_Water;
}

//
// Effect creation:

if (ground_material == kTileMaterial_Sand)
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
else if (ground_material == kTileMaterial_Stone)
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
}
else if (ground_material == kTileMaterial_Water)
{
	repeat (3)
	{
		fader = instance_create_depth(x, y, depth, o_shoreCircleBallFader);
		fader.x += random_range(-6, +6);
		fader.y += random_range(-1, +1);
		fader.image_xscale = 1 / 64.0;
		fader.image_yscale = fader.image_xscale * 0.75;
	}
}