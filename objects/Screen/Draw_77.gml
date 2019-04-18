/// @description Upscale & push to screen

view_set_camera(1, m_outputCamera);
view_set_visible(0, false);
view_set_visible(1, true);

// Pop the stack
//surface_reset_target();

// update effects
with (o_replatte) event_user(0);
with (o_darkness) event_user(0);
with (o_PlayerHud) event_user(0);

// Upscale to the screen
surface_set_target(m_outputSurface);
camera_apply(m_outputCamera);
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
	
	// Draw the screen
	draw_set_color(c_white);
	draw_surface_stretched(m_gameSurface, offset_x * pixelScale, offset_y * pixelScale, Screen.width, Screen.height);
}
surface_reset_target();

// Copy to the backbuffer
camera_apply(m_outputCamera);
gpu_set_blendenable(false);
gpu_set_blendmode_ext(bm_one, bm_zero);
draw_set_color(c_white);
if (!window_get_fullscreen())
{
	draw_surface_stretched(m_outputSurface, 0, 0, window_get_width(), window_get_height());
}
else
{
	var scale_x = Screen.width / display_get_width();
	var scale_y = Screen.height / display_get_height();
	draw_surface_stretched(m_outputSurface, 0, 0, display_get_width() * scale_x, display_get_height() * scale_y);
}
