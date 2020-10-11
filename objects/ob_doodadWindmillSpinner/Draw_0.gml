/// @description Draw doodad w/ far shadow
/*if (!drawbuf_get_reflection())
{
	//var height = sprite_get_height(sprite_index);
	//var shadowOffset = ceil(height / 64.0);
	//var shadowClip = ceil(height / 4.0);

	gpu_set_alphatestenable(false);
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	shader_set(sh_colormaskAlphatest); // shader_set is slow as FUCK

	draw_sprite_ext(
		sprite_index, image_index,
		x, y + 240 + 80,
		image_xscale, -image_yscale, -image_angle,
		shadowSillohuetteColor(),
		image_alpha);
	
	shader_reset();
}

gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);
draw_self();*/