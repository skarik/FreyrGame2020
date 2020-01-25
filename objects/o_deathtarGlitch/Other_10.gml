/// @description Render the effect

if (surface_exists(m_glitchBaseBuffer))
{
	// Draw the effect!
	//surface_set_target(
	
	// render effect directly
	surface_set_target(Screen.m_gameSurface);
	{
		gpu_set_blendenable(true);
		gpu_set_blendmode(bm_normal);
	
		//draw_surface(m_repaletteBuffer, 0, 0);
		draw_surface_ext(m_glitchBaseBuffer, 0, 0,
						 1.0, 1.0, 0.0, c_white,
						 saturate(1.0 - m_glitchFader));
		
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
	
}