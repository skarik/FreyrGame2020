/// @description Draw the water

// Get texture information
/*var texturePaletteLut = sprite_get_texture(s_paletteWater, 0);
var textureAtlasCoords = sprite_get_uvs(s_paletteWater, 0);
//var texturePeturb = surface_get_texture(m_surfacePeturb);

	// Set up the shader
	shader_set(sh_metaballWater2);
	texture_set_stage(uni_samplerPaletteLUT, texturePaletteLut);
	//texture_set_stage(uni_samplerPeturb, texturePeturb);
	gpu_set_texfilter_ext(uni_samplerPeturb, true);
	shader_set_uniform_f(uni_paletteAtlasCoords,
		textureAtlasCoords[0], textureAtlasCoords[1],
		textureAtlasCoords[2] - textureAtlasCoords[0],
		textureAtlasCoords[3] - textureAtlasCoords[1]);
	//shader_set_uniform_f(uni_waterTexelSize,
	//	1.0 / surface_get_width(m_surface), 1.0 / surface_get_height(m_surface));
	shader_set_uniform_f(uni_currentTime,
		Time.time);

draw_tilemap(target_tilemap, 0, 0);

	// Reset drawing status
	shader_reset();*/
var y_position_offset = 0.0;//round(sin(current_time * 0.0014) * 1.4) - 1;
	
gpu_set_alphatestenable(true);
gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_zero, bm_zero);
draw_tilemap(target_tilemap, 0, y_position_offset);
gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(false);