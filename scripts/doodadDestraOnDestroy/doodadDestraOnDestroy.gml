repeat (3)
{
	var poof = instance_create_depth(x, y - 4, depth - 1, o_ptcDustPoof);
	poof.m_direction = random(360);
	poof.m_xspeed = lengthdir_x(random_range(10.0, 40.0), poof.m_direction);
	poof.m_yspeed = lengthdir_y(random_range(10.0, 40.0), poof.m_direction);
	poof.m_friction = 80.0;
	poof.m_life = 0.9;
	poof.m_size = 13.0;
	poof.image_blend = c_ltgray;
	
	// Sound for the hit
	// TODO: different sounds for different sprites
	var audio = sound_play_at(x, y, snd_physKeyBreak0);
	audio.pitch = random_range(1.1, 1.2);
	audio.gain = 0.8 / max(1.0, audio.pitch);
	audio.falloff_start = 20;
	audio.falloff_end = 800;
	audio.falloff_factor = 2;
}

if (exists(collider))
{
	delete(collider);
}
if (exists(light))
{
	delete(light);
}
if (exists(emissive))
{
	delete(emissive);
}