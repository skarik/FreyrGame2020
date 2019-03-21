/// @description Draw the water surface

if (exists(o_waterMetaball) && surface_exists(m_surface))
{
	// Get texture information
	var texturePaletteLut = sprite_get_texture(s_paletteWater, 0);
	var textureAtlasCoords = sprite_get_uvs(s_paletteWater, 0);
	
	// Set up the shader
	shader_set(sh_metaballWater);
	texture_set_stage(uni_samplerPaletteLUT, texturePaletteLut);
	shader_set_uniform_f(uni_paletteAtlasCoords,
		textureAtlasCoords[0], textureAtlasCoords[1],
		textureAtlasCoords[2] - textureAtlasCoords[0],
		textureAtlasCoords[3] - textureAtlasCoords[1]);
	shader_set_uniform_f(uni_waterTexelSize,
		1.0 / surface_get_width(m_surface), 1.0 / surface_get_height(m_surface));
	shader_set_uniform_f(uni_currentTime,
		current_time / 1000.0);

	// Draw the water
	draw_set_color(c_white);
	draw_surface(m_surface, GameCamera.view_x, GameCamera.view_y);
	
	// Reset drawing status
	shader_reset();
}