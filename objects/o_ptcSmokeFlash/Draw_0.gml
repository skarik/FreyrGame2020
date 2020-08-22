/// @description Draw with togglable flash

if (m_flash)
{
	shader_set(sh_colormaskAlphatest);
	draw_set_color(image_blend);
	draw_sprite_ext(sprite_index, image_index, x, round(y) - round(z_height),
					image_xscale, image_yscale, image_angle,
					c_white, 1.0);
	shader_reset();
}
else
{
	draw_set_color(c_white);
	draw_sprite_ext(sprite_index, image_index, x, round(y) - round(z_height),
					image_xscale, image_yscale, image_angle,
					image_blend, saturate(image_alpha));
}