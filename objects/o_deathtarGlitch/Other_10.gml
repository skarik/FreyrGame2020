/// @description Render the effect

if (surface_exists(m_glitchBaseBuffer))
{
	// Create the delta buffer
	if (!surface_exists(m_glitchDeltaBuffer))
	{
		m_glitchDeltaBuffer = surface_create(surface_get_width(m_glitchBaseBuffer), surface_get_height(m_glitchBaseBuffer));
		surface_set_target(m_glitchDeltaBuffer);
		
		draw_clear_alpha(c_black, 0.0);
		
		gpu_set_blendenable(true);
		gpu_set_blendmode_ext(bm_one, bm_zero);
		
		shader_set(sh_generateDifferences);
		var textureSceneB = surface_get_texture(Screen.m_gameSurface);
		texture_set_stage(samplerSceneB, textureSceneB);
		shader_set_uniform_f(uSceneBOffset,
							 -(m_glitchBaseX - GameCamera.view_x) * texture_get_texel_width(textureSceneB),
							 -(m_glitchBaseY - GameCamera.view_y) * texture_get_texel_height(textureSceneB));
		draw_surface(m_glitchBaseBuffer, 0, 0);
		shader_reset();
		
		gpu_set_blendmode(bm_normal);
		
		surface_reset_target();
	}
	// Draw the effect!
	//surface_set_target(
	
	// render effect directly
	surface_set_target(Screen.m_gameSurface);
	{
		gpu_set_blendenable(true);
		gpu_set_blendmode(bm_normal);
	
		//draw_surface(m_repaletteBuffer, 0, 0);
		shader_set(sh_colormask);
		draw_surface_ext(m_glitchDeltaBuffer,
						 m_glitchBaseX - GameCamera.view_x, m_glitchBaseY - GameCamera.view_y,
						 1.0, 1.0, 0.0, c_red,
						 saturate(1.0 - m_glitchFader));
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
	
}