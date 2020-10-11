function depthWorldDraw_DoodadTreeWiggle()
{
	var coords = sprite_get_uvs(sprite_index, image_index);
	var wind_factor = 0.0;
	
	//shader_set(sh_normalTreeWiggle);
	// The shader set/reset for this type is handled by DepthRenderer.
	// It's so common, it gets its own management.
	
	shader_set_uniform_f(u_spriteCoords, coords[0], coords[1], coords[2], coords[3]);
	shader_set_uniform_f(u_spriteTexelCount, sprite_get_width(sprite_index), sprite_get_height(sprite_index));
	shader_set_uniform_f(u_animationValues, Time.time, sin(Time.time), wind_factor, id % 314);
	
	draw_sprite_ext(sprite_index, image_index,
					x, y,
					image_xscale, image_yscale, image_angle,
					image_blend, image_alpha);
	
	//shader_reset();
}