/// @description draw light

// Inherit the parent event
event_inherited();

draw_sprite_ext(sprite_index, image_index,
				x + xoffset, y + yoffset,
				image_xscale, image_yscale,
				image_angle, merge_color(image_blend, c_black, 0.2), 1.0);