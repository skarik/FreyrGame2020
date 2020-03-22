/// @description Draw the farmland surface

if (exists(ob_areaFarmable) && surface_exists(m_surface))
{
	// Get texture information
	var texturePaletteLut = sprite_get_texture(s_paletteFarmland, 0);
	var textureAtlasCoords = sprite_get_uvs(s_paletteFarmland, 0);
	var texturePeturb = surface_get_texture(m_surfacePeturb);
	
	// Set up the shader
	shader_set(sh_metaballFarmland);
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
}