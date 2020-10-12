/// @description Draw the doodad
/*
var x_float = round(sin(current_time * 0.00176 * wiggle_x_mod + id) * 1.1);
var y_float = round(cos(current_time * 0.00233 * wiggle_y_mod + id) * 0.5 + 0.5);

if (!drawbuf_get_reflection())
{
	var height = sprite_get_height(sprite_index);
	var shadowOffset = ceil(height / 64.0);
	var shadowClip = ceil(height / 4.0);

	gpu_set_alphatestenable(false);
	gpu_set_blendenable(true);
	shader_set(sh_colormaskAlphatest); // shader_set is slow as FUCK

	// Draw Shadow A
	draw_sprite_part_ext(
		sprite_index, image_index,
		0, height - shadowClip,
		sprite_get_width(sprite_index), shadowClip,
		x - sprite_xoffset + x_float, y + shadowOffset - sprite_yoffset + (height - shadowClip) + y_float,
		image_xscale, image_yscale,
		waterOcclusionColor(),
		image_alpha);
		
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	
	// Draw Shadow B
	draw_sprite_part_ext(
		sprite_index, image_index,
		0, 0,
		sprite_get_width(sprite_index), sprite_yoffset,
		x - sprite_xoffset + x_float, y - sprite_yoffset + sprite_yoffset + height * 0.5 + y_float,
		image_xscale, -image_yscale * 0.5,
		shadowSillohuetteColor(),
		image_alpha);
	
	shader_reset();
}

gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);
//draw_self();
draw_sprite_ext(
	sprite_index, image_index,
	x + x_float, y + y_float,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
	*/