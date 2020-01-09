/// @description Draw the doodad with special shadow

if (!drawbuf_get_reflection())
{
	var height = sprite_get_height(sprite_index);
	var shadowOffset = ceil(height / 64.0);
	var shadowClip = ceil(height / 4.0);

	gpu_set_alphatestenable(false);
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	shader_set(sh_colormaskAlphatest); // shader_set is slow as FUCK

	// Draw Shadow A
	draw_sprite_part_ext(
		sprite_index, image_index,
		0, height - shadowClip,
		sprite_get_width(sprite_index), shadowClip,
		x - sprite_xoffset, y + shadowOffset - sprite_yoffset + (height - shadowClip),
		image_xscale, image_yscale,
		shadowOcclusionColor(),
		image_alpha);
	
	// Draw Shadow B
	/*draw_sprite_part_ext(
		sprite_index, image_index,
		0, 0,
		sprite_get_width(sprite_index), sprite_yoffset,
		x - sprite_xoffset, y - sprite_yoffset + sprite_yoffset + height * 0.5,
		image_xscale, -image_yscale * 0.5,
		shadowSillohuetteColor(),
		image_alpha);*/
	draw_sprite_ext(
		sprite_index, image_index,
		x, y - 16 * image_yscale,
		image_xscale, image_yscale * -0.25,
		0.0,
		//shadowSillohuetteColor(),
		shadowOcclusionColor(),
		image_alpha);
	
	shader_reset();
}

gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);
draw_self();