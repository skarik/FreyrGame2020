/// @description Upscale & push to screen

view_set_camera(1, m_outputCamera);
view_set_visible(0, false);
view_set_visible(1, true);

// Pop the stack
//surface_reset_target();

// update the palette:
global.pal_surface3d = paletteUpdate();

// Upscale to the screen
surface_set_target(m_outputSurface);
camera_apply(m_outputCamera);
{
	gpu_set_blendenable(false);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	
	//draw_set_color(c_blue);
	//draw_rectangle(0, 0, Screen.width * 0.9, Screen.height * 0.9, false); // Debug blue.
	
	// Set up the shader
	shader_set(sh_repaletteScene);
	texture_set_stage(uni_samplerPaletteLUT, surface_get_texture(global.pal_surface3d));
	shader_set_uniform_f(uni_lookupDivs,
		1.0 / global.pal_lutWidth, 1.0, global.pal_lutWidth, 1.0 / global.pal_lutWidth);

	// Draw the screen
	draw_set_color(c_white);
	draw_surface_stretched(m_gameSurface, 0, 0, Screen.width, Screen.height);
	
	// Reset drawing status
	shader_reset();
}
surface_reset_target();

// Copy to the backbuffer
camera_apply(m_outputCamera);
gpu_set_blendenable(false);
gpu_set_blendmode_ext(bm_one, bm_zero);
draw_set_color(c_white);
draw_surface_stretched(m_outputSurface, 0, 0, window_get_width(), window_get_height());
