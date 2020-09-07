function effectOnPlantHarvest(argument0, argument1) {
	var tx = argument0;
	var ty = argument1;

	var poof;

	/*for (var dir = 0; dir < 360; dir += 120)
	{
		poof = instance_create_depth(tx, ty, depth + 2, o_ptcDustPoof);
		poof.m_direction = dir;
		poof.m_xspeed = lengthdir_x(50.0, poof.m_direction);
		poof.m_yspeed = lengthdir_y(50.0, poof.m_direction);
		poof.m_friction = 80.0;
		poof.m_life = 0.9;
		poof.m_size = 6.0;
		poof.image_blend = c_ltgray;
	}*/
	repeat (3)
	{
		poof = instance_create_depth(tx, ty, depth + 2, o_ptcDustPoof);
		poof.m_direction = random(360);
		poof.m_xspeed = lengthdir_x(30.0, poof.m_direction);
		poof.m_yspeed = lengthdir_y(30.0, poof.m_direction);
		poof.m_friction = 80.0;
		poof.m_life = 0.9;
		poof.m_size = 6.0;
		poof.image_blend = c_ltgray;
	}

	// todo: dirt particles that go UP

	// create circle bit
	/*var circle = instance_create_depth(tx, ty, depth + 1, o_ptcCircleHit);
		circle.image_blend = merge_color(c_white, c_crystalblue, 0.5);
		circle.growSpeed = 60;
		circle.slowAccel = circle.growSpeed * 4;
		circle.fadeSpeed = 10;*/

	var sound_hit;

	// make sound
	sound_hit = sound_play_at(
		random_range(x - 4, x + 4),
		random_range(y - 4, y + 4),
		choose(snd_physStepGrass1, snd_physStepGrass2, snd_physStepGrass3)
		);
	sound_hit.pitch = random_range(0.50, 0.60) * 0.9;
	sound_hit.gain = random_range(0.7, 0.9) * 0.2;
	sound_hit.falloff_start = 20;
	sound_hit.falloff_end = 800;
	sound_hit.falloff_factor = 1;
	sound_hit.parent = id;

	// make sound
	sound_hit = sound_play_at(
		random_range(x - 4, x + 4),
		random_range(y - 4, y + 4),
		snd_npcDigpop
		);
	sound_hit.pitch = random_range(0.95, 1.1);
	sound_hit.gain = random_range(0.7, 0.9) * 0.7;
	sound_hit.falloff_start = 20;
	sound_hit.falloff_end = 800;
	sound_hit.falloff_factor = 1;
	sound_hit.parent = id;


}
