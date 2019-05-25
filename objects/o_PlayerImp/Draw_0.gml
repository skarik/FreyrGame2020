/// @description draw with a bit of hovering

draw_sprite_ext(sprite_index, image_index,
				x,
				round(y + sin(current_time * 0.003) * 2.4),
				image_xscale, image_yscale, image_angle,
				image_blend, image_alpha);