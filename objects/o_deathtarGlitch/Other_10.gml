/// @description Render the effect

if (surface_exists(m_glitchBaseBuffer))
{
	// Create the delta buffer
	if (!surface_exists(m_glitchDeltaBuffer))
	{
		m_glitchDeltaBuffer = surface_create(surface_get_width(m_glitchBaseBuffer), surface_get_height(m_glitchBaseBuffer));
		surface_set_target(m_glitchDeltaBuffer);
		
		draw_clear_alpha(c_black, 0.0);
		
		gpu_set_blendenable(false);
		gpu_set_blendmode_ext(bm_one, bm_zero);
		
		shader_set(sh_generateDifferences);
		var textureSceneB = surface_get_texture(Screen.m_gameSurface);
		texture_set_stage(samplerSceneB, textureSceneB);
		shader_set_uniform_f(uSceneBOffset,
							 (m_glitchBaseX - GameCamera.view_x) * texture_get_texel_width(textureSceneB),
							 (m_glitchBaseY - GameCamera.view_y) * texture_get_texel_height(textureSceneB));
		draw_surface(m_glitchBaseBuffer, 0, 0);
		shader_reset();
		
		surface_reset_target();
	}
	// Perform the delta-fuck
	if (!surface_exists(m_glitchFuckBuffer))
	{
		m_glitchFuckBuffer = surface_create(surface_get_width(m_glitchBaseBuffer), surface_get_height(m_glitchBaseBuffer));
		surface_set_target(m_glitchFuckBuffer);
		
		draw_clear_alpha(c_black, 0.0);
		gpu_set_blendenable(false);
		gpu_set_blendmode_ext(bm_one, bm_zero);
		
		draw_surface(m_glitchDeltaBuffer, 0, 0);
		
		surface_reset_target();
	}
	m_glitchFuckStepSimmer += Time.deltaTime * 25.0;
	if (m_glitchFuckStepSimmer > 0)
	{
		var temp_glitchfuck = surface_create(surface_get_width(m_glitchBaseBuffer), surface_get_height(m_glitchBaseBuffer));
		while (m_glitchFuckStepSimmer > 0)
		{		
			// Perform the washy simulation
			surface_set_target(temp_glitchfuck);
			draw_clear_alpha(c_black, 0.0);
		
			gpu_set_blendenable(false);
			gpu_set_blendmode_ext(bm_one, bm_zero);
		
			var washy_texture = surface_get_texture(m_glitchFuckBuffer);
		
			shader_set(sh_washyBlurStep);
			shader_set_uniform_f(uTexelSize,
								 texture_get_texel_width(washy_texture),
								 texture_get_texel_height(washy_texture));
			shader_set_uniform_f(uCurrentTime, Time.time);
			draw_surface(m_glitchFuckBuffer, 0, 0);
			shader_reset();
		
			surface_reset_target();
		
			// Copy the result back
			surface_set_target(m_glitchFuckBuffer);
			draw_clear_alpha(c_black, 0.0);
			gpu_set_blendenable(true);
			gpu_set_blendmode(bm_normal);
			draw_surface(temp_glitchfuck, 0, 0);
			surface_reset_target();
		
			// Done with this step
			m_glitchFuckStepSimmer -= 1.0;
		}
		// Remove the temp buffer
		surface_free(temp_glitchfuck);
	}
	
	// render effect directly
	surface_set_target(Screen.m_gameSurface);
	{
		gpu_set_blendenable(true);
		gpu_set_blendmode(bm_normal);
	
		//draw_surface(m_repaletteBuffer, 0, 0);
		//shader_set(sh_colormask);
		draw_surface_ext(m_glitchFuckBuffer,
						 m_glitchBaseX - GameCamera.view_x, m_glitchBaseY - GameCamera.view_y,
						 1.0, 1.0, 0.0, c_white,
						 saturate(2.0 - 2.0 * m_glitchFader));
		//shader_reset();
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