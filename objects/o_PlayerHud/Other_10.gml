/// @description push directly to game surface

// copy back
surface_set_target(Screen.m_gameSurface);
{	
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);
	
	// draw lightweight back
	if (surface_exists(m_surfaceLightweightBack))
		draw_surface(m_surfaceLightweightBack, 0, 0);
	
	// draw heavy
	gpu_set_blendmode_ext(bm_zero, bm_inv_src_alpha);
	for (var ix = -1; ix <= 1; ++ix)
		for (var iy = -1; iy <= 1; ++iy)
			draw_surface(m_surface, +ix, +iy);
	gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);
	draw_surface(m_surface, 0, 0);
	
	// draw lightweight
	if (surface_exists(m_surfaceLightweight))
		draw_surface(m_surfaceLightweight, 0, 0);
}
surface_reset_target();