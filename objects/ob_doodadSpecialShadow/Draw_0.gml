/// @description Insert description here
// You can write your code in this editor

gpu_set_alphatestenable(false);
gpu_set_blendenable(true);
gpu_set_blendmode_ext(bm_dest_color, bm_zero);
shader_set(sh_colormaskAlphatest); // shader_set is slow as FUCK

// Draw special shadow
draw_sprite_ext(
	shadow_index, image_index,
	x, y,
	image_xscale, image_yscale,
	image_angle,
	shadowSillohuetteColor(),
	image_alpha);
	
shader_reset();

gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);
draw_self();