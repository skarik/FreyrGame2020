/// @description Insert description here
// You can write your code in this editor

draw_sprite_ext(sprite_index, image_index,
				x + xoffset, y + yoffset,
				image_xscale, image_yscale,
				image_angle, c_electricity,
				image_alpha * (sin(Time.time) * 0.2 + 0.8));