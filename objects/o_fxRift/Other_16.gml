/// @description Unified draw

// Draw the rift first
shader_set(sh_rift);
{
	// Get texture information
	var textureAtlasCoords = sprite_get_uvs(sprite_index, 0);
	// Set up the shader
	shader_set_uniform_f(uni_paletteAtlasCoords,
		textureAtlasCoords[0], textureAtlasCoords[1],
		textureAtlasCoords[2] - textureAtlasCoords[0],
		textureAtlasCoords[3] - textureAtlasCoords[1]);
	shader_set_uniform_f(uni_currentTime,
		Time.time);

	var prev_x = x;
	var prev_y = y;
	x += xoffset;
	y += yoffset - z_height;
	{
		draw_self();
	}
	x = prev_x;
	y = prev_y;
}
shader_reset();