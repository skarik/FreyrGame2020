/// @description Draw power & effects

// Draw backside
draw_sprite_ext(sprite_index, image_index,
				x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

// Draw power line
if (visual_power > 0.0)
{
	draw_set_color(c_towerdiamond);
	draw_rectangle(x - visual_power * 3.0, y + 2,
				   x + 1 + visual_power * 2.0, y - 16 * 2.5 - 1,
				   false);
}

// Draw front bits
draw_sprite_ext(sprite_index, image_index + 1,
				x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);