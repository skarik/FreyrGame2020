/// @description Update visiblity

// Update visibility with a large margin in case camera moves fast.
visible = point_on_camera_wide(x, y, abs(sprite_width) + 64, abs(sprite_height) + 64);

if (visible)
{
	// Spawn leafs in big wind
	var wind = weatherGetWind();

	if (abs(wind[0]) > 20.0)
	{
		spawnTimer += abs(wind[0]) * m_grassBitsCount * Time.deltaTime * 0.0003;
		
		// Spawn a buncha leaves!
		while (spawnTimer > 1.0)
		{
			spawnTimer -= 1.0;
		
			var leaf_i = floor(random(m_grassBitsCount - 0.01));
		
			var grass = m_grassBits[leaf_i];
		
			// choose a grass to spawn
			var leaf = inew(o_ptcWheatLeaf);
				leaf.x = grass[0];
				leaf.y = grass[1];
				leaf.xspeed = (wind[0] + random_range(-9.0, +9.0)) * 0.5;
				leaf.yspeed = (4.0 + wind[1] + random_range(-9.0, +9.0)) * 0.5;
				leaf.z_height = 20;
				leaf.zgravity *= 0.5;
		}
	}
}