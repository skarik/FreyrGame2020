/// @description Draw sprite glow

draw_sprite_ext(sprite_index, 2,
				x + xoffset, y - z_height + yoffset,
				image_xscale, image_yscale,
				image_angle,
				merge_color(c_black, image_blend, lightingPower * image_alpha * 0.8),
				1.0);
				
draw_set_alpha(1.0);
draw_set_color(merge_color(c_black, c_towercrystal, 0.1 * lightingPower));
draw_circle(x + xoffset, y + yoffset, 20 + 20 * lightingPower, false);
draw_circle_color(x + xoffset, y + yoffset,
				  40 + 40 * lightingPower,
				  merge_color(c_black, c_towercrystal, 0.05 * lightingPower),
				  c_black,
				  false);