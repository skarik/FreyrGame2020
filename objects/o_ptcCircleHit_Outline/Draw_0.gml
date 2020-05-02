/// @description draw effect circle

var t_effectBuffer = surface_create(radius * 2 + 2, radius * 2 + 2);

surface_set_target(t_effectBuffer);
{
	draw_clear_alpha(c_black, 0.0);
	
	shader_set(sh_dispelFadeOut);
	texture_set_stage(samplerTexNoise, fadeoutNoiseTexture);
	shader_set_uniform_f(uTexNoiseSize, 32, 32);
	shader_set_uniform_f(uTexNoiseCoords, fadeoutNoiseCoords[0], fadeoutNoiseCoords[1], fadeoutNoiseCoords[2], fadeoutNoiseCoords[3]);
	shader_set_uniform_f(uEffectiveAlpha, sqrt(abs(image_alpha)));

	draw_set_color(image_blend);
	draw_circle(radius + 1, radius + 1, radius - 0.2, true);
	draw_circle(radius + 1, radius + 1, radius, true);
	draw_circle(radius + 1, radius + 1, radius + 0.2, true);

	shader_reset();
}
surface_reset_target();

// draw outline
draw_surface_ext(t_effectBuffer, x - radius - 1, y - radius, 1.0, 1.0, 0.0, c_black, 1.0);
draw_surface_ext(t_effectBuffer, x - radius + 1, y - radius, 1.0, 1.0, 0.0, c_black, 1.0);
draw_surface_ext(t_effectBuffer, x - radius, y - radius - 1, 1.0, 1.0, 0.0, c_black, 1.0);
draw_surface_ext(t_effectBuffer, x - radius, y - radius + 1, 1.0, 1.0, 0.0, c_black, 1.0);

// draw effect
draw_set_color(c_white);
draw_surface(t_effectBuffer, x - radius, y - radius);

surface_free(t_effectBuffer);