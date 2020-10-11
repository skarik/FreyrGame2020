/// @description draw sprite with depth

if (!color_setup)
{
	m_color = color_multiply(target.image_blend, image_blend);
	color_setup = true;
}

if (mask)
	shader_set(sh_colormaskAlphatest);
	
draw_set_color(c_white);
draw_sprite_ext(sprite_exists(sprite_index) ? sprite_index : target.sprite_index,
				target.image_index,
				target.x + xoffset, target.y + yoffset,
				target.image_xscale, target.image_yscale,
				target.image_angle,
				m_color,
				target.image_alpha * image_alpha);
if (mask)
	shader_reset();