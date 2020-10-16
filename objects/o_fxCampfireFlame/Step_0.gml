/// @description Spawn flames

var bRunParticleSystem = false;
if (!m_nightOnly)
{
	bRunParticleSystem = true;
}
else
{
	bRunParticleSystem = !timeofdayIsDaytime();
}

if (bRunParticleSystem && point_on_camera_wide(x, y, 32, 32))
{
	flameTimer0 += 18.0 * Time.deltaTime;
	smokeTimer0 += 8.0 * Time.deltaTime;

	while (flameTimer0 > 0)
	{
		flameTimer0 -= 1.0;
		var flame = instance_create_depth(x + random_range(-2, +2),
										  y + random_range(-1, +1),
										  depth - 1,
										  o_ptcFlameZBit);
			flame.z = z;
	}
	
	while (smokeTimer0 > 0)
	{
		smokeTimer0 -= 1.0;
		var flame = instance_create_depth(x + random_range(-2, +2),
										  y + random_range(-1, +1),
										  depth + 1,
										  o_ptcSmokeZBit);
			flame.z = z;
	}
	
	if (m_sound == null)
	{
		m_sound = sound_play_at(x, y, "audio/elements/fire_medium.wav");
		m_sound.pitch = 1.0;
		m_sound.gain = 0.3;
		m_sound.falloff_start = 20;
		m_sound.falloff_end = 220;
		m_sound.falloff_factor = 2;
		m_sound.loop = true;
		m_sound.parent = id;
	}
}
else
{
	if (m_sound != null)
	{
		idelete(m_sound);
		m_sound = null;
	}
}