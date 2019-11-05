var tx = argument0;
var ty = argument1;

var poof, footstep, fader, sound_hit;

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


if (ground_material == kTileMaterial_Sand)
{
	for (var dir = 0; dir < 360; dir += 60)
	{
		poof = instance_create_depth(tx, ty, depth - 1, o_ptcDustPoof);
		poof.m_direction = dir;
		poof.m_xspeed = lengthdir_x(40.0, poof.m_direction);
		poof.m_yspeed = lengthdir_y(40.0, poof.m_direction);
		poof.m_friction = 80.0;
		poof.m_life = 0.9;
		poof.m_size = 6.0;
		poof.image_blend = c_ltgray;
	}
	repeat (3)
	{
		poof = instance_create_depth(tx, ty, depth - 1, o_ptcDustPoof);
		poof.m_direction = random(360);
		poof.m_xspeed = lengthdir_x(40.0, poof.m_direction);
		poof.m_yspeed = lengthdir_y(40.0, poof.m_direction);
		poof.m_friction = 80.0;
		poof.m_life = 0.9;
		poof.m_size = 11.0;
		poof.image_blend = c_ltgray;
	}
	
	// make sound
	sound_hit = sound_play_at(
		random_range(x - 4, x + 4),
		random_range(y - 4, y + 4),
		choose(snd_physLandSand1, snd_physLandSand1)
		);
	sound_hit.pitch = random_range(0.9, 1.0);
	sound_hit.gain = 1.1;
	sound_hit.falloff_start = 20;
	sound_hit.falloff_end = 800;
	sound_hit.falloff_factor = 1;
	sound_hit.parent = id;
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
	
	// make sound
	sound_hit = sound_play_at(
		random_range(x - 4, x + 4),
		random_range(y - 4, y + 4),
		choose(snd_physStepDirt1, snd_physStepDirt2)
		);
	sound_hit.pitch = random_range(0.7, 0.8);
	sound_hit.gain = 1.1;
	sound_hit.falloff_start = 20;
	sound_hit.falloff_end = 800;
	sound_hit.falloff_factor = 1;
	sound_hit.parent = id;
}
else if (ground_material == kTileMaterial_Water)
{
	repeat (5)
	{
		fader = instance_create_depth(x, y, depth, o_shoreCircleBallFader);
		fader.x += random_range(-16, +16);
		fader.y += random_range(-12, +12);
		fader.image_xscale = random_range(1 / 64.0, 1 / 32.0);
		fader.image_yscale = fader.image_xscale * 0.75;
	}
	
	// make sound
	sound_hit = sound_play_at(
		random_range(x - 4, x + 4),
		random_range(y - 4, y + 4),
		choose(snd_physLandWater1, snd_physLandWater1)
		);
	sound_hit.pitch = random_range(0.9, 1.1);
	sound_hit.gain = 0.8;
	sound_hit.falloff_start = 20;
	sound_hit.falloff_end = 800;
	sound_hit.falloff_factor = 1;
	sound_hit.parent = id;
}
else if (ground_material == kTileMaterial_Grass)
{
	// make sound
	sound_hit = sound_play_at(
		random_range(x - 4, x + 4),
		random_range(y - 4, y + 4),
		choose(snd_physStepGrass1, snd_physStepGrass2, snd_physStepGrass3)
		);
	sound_hit.pitch = random_range(0.95, 1.0);
	sound_hit.gain = 1.1;
	sound_hit.falloff_start = 20;
	sound_hit.falloff_end = 800;
	sound_hit.falloff_factor = 1;
	sound_hit.parent = id;
}