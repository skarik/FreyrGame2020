/// @description Draw sprite glow

var dx, dy, ro2
dx = round(x);
dy = round(y);
ro2 = sin(current_time * 0.025 + id) * 0.7;

draw_sprite_ext(sprite_index, 1,
				dx + xoffset, round(dy - z_height) + yoffset,
				image_xscale, image_yscale,
				image_angle,
				merge_color(c_black, image_blend, m_lightingPower * image_alpha * 1.0),
				1.0);
				
draw_set_alpha(1.0);
draw_set_color(merge_color(c_black, c_towercrystal, 0.1 * m_lightingPower));
draw_circle(x - 1 + xoffset, y - 1 - z_height + yoffset, 5 + 5 * m_lightingPower + ro2, false);
/*draw_circle_color(x + xoffset, y + yoffset,
				  40 + 40 * lightingPower,
				  merge_color(c_black, c_towercrystal, 0.05 * lightingPower),
				  c_black,
				  false);*/