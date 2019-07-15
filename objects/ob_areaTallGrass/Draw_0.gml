/// @description temp draw grass

var pl = getPlayer();

// draw shadow
gpu_set_alphatestenable(false);
gpu_set_blendenable(true);
gpu_set_blendmode_ext(bm_dest_color, bm_zero);
draw_set_color(merge_color(merge_color(c_white, c_gold, 0.125), c_black, 0.125));
for (var i = 0; i < m_grassBitsCount; ++i)
{
	var i_grass = m_grassBits[i];
	draw_circle(i_grass[0], i_grass[1], 3.5 - i_grass[2] * 0.5, false);
}
/*
// draw grass
gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);
for (var i = 0; i < m_grassBitsCount; ++i)
{
	var i_grass = m_grassBits[i];
	var pl_dist = sqr(i_grass[0] - pl.x) + sqr(i_grass[1] - pl.y) * 3.0;
	
	var grass_angle = 0.0;
	grass_angle += -25.0 * max(0.0, (40.0 - pl_dist * 0.07) / 40.0) * sign(i_grass[0] - pl.x);
	
	grass_angle += sin(i * 32.13124 + current_time * 0.002) * 2.0;
	grass_angle += sin(i_grass[0] * 0.042 + i_grass[1] * 0.016 + current_time * 0.0017) * 10.0;
	
	var grass_color = merge_color(c_white, c_black, abs(grass_angle - 3.0) / 60.0);
	
	draw_sprite_ext(s_assetTallGrass, i_grass[2], i_grass[0], i_grass[1], i_grass[3], 1.0, grass_angle, grass_color, 1.0);
}*/

var wind_factor = 0.0;

gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);
shader_set(sh_wavyGrass);
//texture_set_stage(samplerGrassTexture, sprite_get_texture(s_assetTallGrass, 0));
shader_set_uniform_f(u_animationValues, current_time / 1000.0, sin(current_time / 1000.0), wind_factor, id % 314);
vertex_submit(m_vbuf, pr_trianglelist, sprite_get_texture(s_assetTallGrass, 0));
shader_reset();
