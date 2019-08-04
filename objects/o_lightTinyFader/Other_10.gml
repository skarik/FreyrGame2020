/// @description create that gentle glow

draw_circle_color(x + xoffset, y + yoffset,
				  m_radius,
				  merge_color(c_black, image_blend, saturate(m_radius / 5.0)),
				  c_black,
				  false);