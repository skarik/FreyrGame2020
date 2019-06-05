/// @description push directly to game surface

// copy back
surface_set_target(Screen.m_gameSurface);

if (m_inCutsceneBlend < 1.0)
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
// Draw the bars at top and bottom
if (m_inCutsceneBlend > 0.0)
{
	draw_set_color(c_black);
	draw_set_alpha(1.0);
	draw_rectangle(0, 0, GameCamera.width, 20 * m_inCutsceneBlend, false);
	draw_rectangle(0, GameCamera.height - 20 * m_inCutsceneBlend, GameCamera.width, GameCamera.height, false);
}

surface_reset_target();