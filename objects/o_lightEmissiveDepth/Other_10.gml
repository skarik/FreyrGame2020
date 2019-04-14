/// @description draw sprite with depth

if (mask)
	shader_set(sh_colormaskAlphatest);
	
draw_set_color(c_white);
draw_sprite_ext(target.sprite_index, target.image_index,
				target.x + xoffset, target.y - target.z_height + yoffset,
				target.image_xscale, target.image_yscale,
				target.image_angle,
				target.image_blend,
				target.image_alpha);
if (mask)
	shader_reset();