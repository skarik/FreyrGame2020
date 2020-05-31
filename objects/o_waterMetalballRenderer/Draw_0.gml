/// @description Draw the water surface

if (iexists(o_waterMetaball) && surface_exists(m_surface) && surface_exists(m_surfacePeturb))
{
	// Get texture information
	var texturePaletteLut = sprite_get_texture(s_paletteWater, 0);
	var textureAtlasCoords = sprite_get_uvs(s_paletteWater, 0);
	var texturePeturb = surface_get_texture(m_surfacePeturb);
	
	// Set up the shader
	shader_set(sh_metaballWater);
	texture_set_stage(uni_samplerPaletteLUT, texturePaletteLut);
	texture_set_stage(uni_samplerPeturb, texturePeturb);
	gpu_set_texfilter_ext(uni_samplerPeturb, true);
	shader_set_uniform_f(uni_paletteAtlasCoords,
		textureAtlasCoords[0], textureAtlasCoords[1],
		textureAtlasCoords[2] - textureAtlasCoords[0],
		textureAtlasCoords[3] - textureAtlasCoords[1]);
	shader_set_uniform_f(uni_waterTexelSize,
		1.0 / surface_get_width(m_surface), 1.0 / surface_get_height(m_surface));
	shader_set_uniform_f(uni_currentTime,
		Time.time);

	// Draw the water
	draw_set_color(c_white);
	draw_surface(m_surface, GameCamera.view_x, GameCamera.view_y);
	
	// Reset drawing status
	shader_reset();
	
	//gpu_set_blendmode(bm_add);
	// Draw the reflections with alpha-testing for blending
	gpu_set_alphatestenable(false);
	/*draw_surface_ext(m_surfaceReflect,
					GameCamera.view_x, GameCamera.view_y + GameCamera.height,
					1.0, -1.0,
					0.0,
					c_white,
					1.0);*/
	/*draw_surface_ext(m_surfaceDepthHack,
					GameCamera.view_x, GameCamera.view_y + GameCamera.height,
					1.0, -1.0,
					0.0,
					c_white,
					1.0);*/
	gpu_set_blendmode(bm_normal);
}