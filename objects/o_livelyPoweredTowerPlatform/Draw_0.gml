/// @description Draw self with Z shadow

var dx, dy;
dx = round(x);
dy = round(y);

shader_set(sh_colormaskAlphatest);
gpu_set_alphatestenable(false);
gpu_set_blendenable(true);
gpu_set_blendmode_ext(bm_dest_color, bm_zero);
draw_set_color(c_white);
draw_sprite_ext(sprite_index, image_index,
				dx, dy,
				image_xscale, image_yscale,
				image_angle,
				c_ltgray,
				image_alpha);
shader_reset();

gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);
draw_sprite_ext(sprite_index, image_index,
				dx, round(dy - z_height),
				image_xscale, image_yscale,
				image_angle,
				image_blend,
				image_alpha);