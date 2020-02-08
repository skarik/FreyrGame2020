/// @description Draw with depth
image_index = 1;
depthDrawSelf();

var dx, dy;
dx = round(x) - 0.5;
dy = round(y) - 3;
draw_set_color(c_white);
draw_circle(dx, round(dy - z_height), round(energyPower * 4.0), false);
draw_circle(dx, round(dy - z_height), round(energyPower * 6.0), true);

draw_sprite_ext(sprite_index, 2,
				round(x),
				round(round(y) - z_height),
				image_xscale, image_yscale,
				image_angle,
				image_blend, image_alpha);
draw_sprite_ext(sprite_index, 3,
				round(x),
				round(round(y) - z_height),
				image_xscale, image_yscale,
				image_angle,
				image_blend, image_alpha);
