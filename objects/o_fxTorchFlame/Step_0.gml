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
		var flame = instance_create_depth(x + random_range(-1, +1),
										  y + random_range(-1, +1),
										  depth - 1,
										  o_ptcFlameZBit);
			flame.z = z + z_height;
			flame.animationSpeed *= 2.4;
			flame.image_yscale = 0.2;
	}
	
	while (smokeTimer0 > 0)
	{
		smokeTimer0 -= 1.0;
		var flame = instance_create_depth(x + random_range(-1, +1),
										  y + random_range(-1, +1),
										  depth + 1,
										  o_ptcSmokeZBit);
			flame.z = z + z_height;
			flame.animationSpeed *= 1.3;
			flame.image_yscale = 0.4;
	}
}