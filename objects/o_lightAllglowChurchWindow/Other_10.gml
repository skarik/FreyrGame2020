/// @description draw fire light


draw_sprite_ext(sprite_index, image_index,
				x + xoffset,
				y + yoffset,
				image_xscale, image_yscale,
				image_angle, merge_color(image_blend, c_white, 0.9), image_alpha);
// use x + xoffset and y + yoffset
// default blend mode is gpu_set_blendmode_ext(bm_src_alpha, bm_one);