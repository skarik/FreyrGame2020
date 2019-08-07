/// @description Draw the grass over-layer

var pl = getPlayer();

gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);

with (ob_areaTallGrass)
{
	if (!visible)
		continue;
	
	// draw grass
	for (var i = 0; i < m_grassBitsCount; ++i)
	{
		var i_grass = m_grassBits[i];
		
		// Skip behind player
		if (i_grass[1] < pl.y)
			continue;

		var pl_dist = sqr(i_grass[0] - pl.x) + sqr(i_grass[1] - pl.y) * 3.0;
		
		// Skip far from player
		if (pl_dist > sqr(50))
			continue;
	
		var grass_angle = 0.0;
		grass_angle += -25.0 * max(0.0, (40.0 - pl_dist * 0.07) / 40.0) * sign(i_grass[0] - pl.x);
	
		grass_angle += sin(i * 32.13124 + current_time * 0.002) * 2.0;
		grass_angle += sin(i_grass[0] * 0.042 + i_grass[1] * 0.016 + current_time * 0.0017) * 10.0;
		
		var grass_color = merge_color(c_white, c_black, abs(3.0 - grass_angle) / 90.0);
	
		draw_sprite_ext(s_assetTallGrass, i_grass[2], i_grass[0], i_grass[1], i_grass[3], 1.0, grass_angle, grass_color, 1.0);
	}
}