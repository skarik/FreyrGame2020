/// @description Insert description here
// You can write your code in this editor

var height = sprite_get_height(sprite_index);
var shadowOffset = ceil(height / 64.0);
var shadowClip = ceil(height / 4.0);

gpu_set_alphatestenable(false);
gpu_set_blendenable(true);
gpu_set_blendmode_ext(bm_dest_color, bm_zero);
shader_set(sh_colormaskAlphatest); // shader_set is slow as FUCK
draw_sprite_part_ext(
	sprite_index, image_index,
	0, height - shadowClip,
	sprite_get_width(sprite_index), shadowClip,
	x - sprite_xoffset, y + shadowOffset - sprite_yoffset + (height - shadowClip),
	image_xscale, image_yscale,
	merge_color(image_blend, c_black, 0.25),
	image_alpha);
shader_reset();

gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);
draw_self();