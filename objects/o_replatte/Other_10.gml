/// @description renders w/ palette to Game

m_repaletteBuffer = surface_create_from_surface_params(Screen.m_gameSurface);

surface_set_target(m_repaletteBuffer);
{
	gpu_set_blendenable(false);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	
	// Clear the screen
	draw_clear(c_black);
	
	// Debug blue to show which area is actually renderable
	if (Debug.visible)
	{
		draw_set_color(c_blue);
		draw_rectangle(0, 0, Screen.width * 0.9, Screen.height * 0.9, false); // Debug blue.
	}
	
	// Set up the shader
	shader_set(sh_repaletteScene);
	texture_set_stage(uni_samplerPaletteLUT, surface_get_texture(global.pal_surface3d));
	gpu_set_tex_filter_ext(uni_samplerPaletteLUT, false);
	gpu_set_tex_repeat_ext(uni_samplerPaletteLUT, false);
	texture_set_stage(uni_samplerPaletteLUTSecond, surface_get_texture(global.pal_surface3d2));
	gpu_set_tex_filter_ext(uni_samplerPaletteLUTSecond, false);
	gpu_set_tex_repeat_ext(uni_samplerPaletteLUTSecond, false);
	shader_set_uniform_f(uni_lookupDivs,
						 1.0 / global.pal_lutWidth,
						 1.0,
						 global.pal_lutWidth, 1.0 / global.pal_lutWidth);
	shader_set_uniform_f(uni_overlayMadd2,
						 color_get_red(global.pal_overlay_madd2) / 255.0,
						 color_get_green(global.pal_overlay_madd2) / 255.0,
						 color_get_blue(global.pal_overlay_madd2) / 255.0,
						 1.0);

	// Draw the screen
	draw_set_color(c_white);
	draw_surface(Screen.m_gameSurface, 0, 0);
	
	// Reset drawing status
	shader_reset();
}
surface_reset_target();

// copy back
/*surface_set_target(Screen.m_gameSurface);
{
	gpu_set_blendenable(false);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	
	draw_surface(m_repaletteBuffer, 0, 0);
	
	gpu_set_blendmode(bm_normal);
}
surface_reset_target();*/

// "copy" back
var l_old_surface = Screen.m_gameSurface;
Screen.m_gameSurface = m_repaletteBuffer;
m_repaletteBuffer = l_old_surface;
surface_free_if_exists(m_repaletteBuffer);