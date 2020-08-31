exit;

if (surface_exists(m_surface) && !o_PlayerTest.m_isKOed && m_inCutsceneBlend < 1.0)
{
	var dx = GameCamera.x - GameCamera.width / 2;
	var dy = GameCamera.y - GameCamera.height / 2;

	draw_set_color(c_white);
	draw_set_alpha(1.0);
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);

	// draw lightweight
	if (surface_exists(m_surfaceLightweightBack))
		draw_surface(m_surfaceLightweightBack, dx, dy);

	// draw heavy
	gpu_set_blendmode_ext(bm_zero, bm_inv_src_alpha);
	for (var ix = -1; ix <= 1; ++ix)
		for (var iy = -1; iy <= 1; ++iy)
			draw_surface(m_surface, dx+ix, dy+iy);
	gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);
	draw_surface(m_surface, dx, dy);
	
	// draw lightweight
	if (surface_exists(m_surfaceLightweight))
		draw_surface(m_surfaceLightweight, dx, dy);
}

// Draw the bars at top and bottom
if (m_inCutsceneBlend > 0.0)
{
	var dx = GameCamera.x - GameCamera.width / 2;
	var dy = GameCamera.y - GameCamera.height / 2;
	
	draw_set_color(c_black);
	draw_set_alpha(1.0);
	draw_rectangle(dx, dy, dx + GameCamera.width, dy + 20 * m_inCutsceneBlend, false);
	draw_rectangle(dx, dy + GameCamera.height - 20 * m_inCutsceneBlend, dx + GameCamera.width, dy + GameCamera.height, false);
}