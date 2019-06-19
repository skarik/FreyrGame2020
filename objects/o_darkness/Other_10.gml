/// @description draw the DARKNESS
/*
// multiply mode:
if (surface_exists(m_darkness))
{
	var dx = GameCamera.x - GameCamera.width / 2;
	var dy = GameCamera.y - GameCamera.height / 2;
	
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	shader_set(sh_shadowBanding);
	draw_surface(m_darkness, dx, dy);
	shader_reset();
	gpu_set_blendmode(bm_normal);
}*/

// create bloom
gpu_set_blendenable(false);
gpu_set_blendmode_ext(bm_one, bm_zero);
gpu_set_tex_filter(true);

shader_set(sh_9tapBlur);
shader_set_uniform_f(uni_pixelSize, 1.0 / surface_get_width(m_bloom), 1.0 / surface_get_height(m_bloom));
{
	surface_set_target(m_bloom2);
	draw_surface_stretched(m_darkness, 0, 0, surface_get_width(m_bloom), surface_get_height(m_bloom));
	surface_reset_target();
	
	surface_set_target(m_bloom);
	draw_surface_stretched(m_bloom2, 0, 0, surface_get_width(m_bloom), surface_get_height(m_bloom));
	surface_reset_target();
}
gpu_set_tex_filter(false);
shader_reset();

// draw the darkness to screen
surface_set_target(Screen.m_gameSurface);
{
	// Multiply effect
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	
	shader_set(sh_shadowBanding);
	shader_set_uniform_f(uni_pixelOffset, (GameCamera.x % 4), (GameCamera.y % 4));
	
	draw_surface(m_darkness, 0, 0);
	
	shader_reset();
	
	// Add in the bloom
	gpu_set_blendmode_ext(bm_src_alpha, bm_one);
	gpu_set_tex_filter(true);
	
	shader_set(sh_bloomDrop);
	shader_set_uniform_f(uni_bloomParams, bloom_drop, bloom_mul);
	draw_surface_stretched_ext(m_bloom,
							   0, 0,
							   surface_get_width(m_darkness), surface_get_height(m_darkness),
							   c_white,
							   1.0);
							   
	shader_reset();
	gpu_set_tex_filter(false);
	
	// Reset blend state
	gpu_set_blendmode(bm_normal);
}
surface_reset_target();