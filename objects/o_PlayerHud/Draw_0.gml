exit;

// test some day night cycles
/*gpu_set_blendenable(true);
gpu_set_blendmode_ext(bm_dest_color, bm_src_color);
var blend0 = 0.0;
var blend1 = 0.0;
blend0 = min(1.0, max(0.0, +sin(current_time / 2000.0) * 1.4));
blend1 = min(1.0, max(0.0, -sin(current_time / 2000.0) * 1.4));
var color0 = merge_color(make_color_rgb(128, 128, 128), make_color_rgb(255 * 0.6, 180 * 0.6, 60 * 0.6), 1.0 - blend0);
color0 = merge_color(color0, make_color_rgb(90, 70, 255), blend1);

draw_set_color(merge_color(make_color_rgb(128, 128, 128), color0, 0.2));
draw_rectangle(GameCamera.x - GameCamera.width, GameCamera.y - GameCamera.height, GameCamera.x + GameCamera.width, GameCamera.y + GameCamera.height, false);
paletteSetMadd2(merge_color(make_color_rgb(128, 128, 128), color0, 0.8));
*/
if (surface_exists(m_surface) && !o_PlayerTest.m_isDead && m_inCutsceneBlend < 1.0)
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