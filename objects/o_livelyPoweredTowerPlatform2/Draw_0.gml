/// @description draw height based on power

draw_sprite_part(sprite_index, image_index,
				 0, 0,
				 16 * 6,
				 16 * 3 + m_height * 5 * 16,
				 x,
				 y + (1.0 - m_height) * 5 * 16);