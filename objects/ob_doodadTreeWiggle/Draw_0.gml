/// @description Insert description here
// You can write your code in this editor

var height = sprite_get_height(sprite_index);
var shadowOffset = ceil(height / 64.0);
var shadowClip = ceil(height / 4.0);

if (shadow_enabled)
{
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
		shadowOcclusionColor(),
		image_alpha);
	
	draw_sprite_part_ext(
		sprite_index, image_index,
		0, 0,
		sprite_get_width(sprite_index), sprite_yoffset,
		x - sprite_xoffset, y - sprite_yoffset + sprite_yoffset + height * 0.5,
		image_xscale, -image_yscale * 0.5,
		shadowSillohuetteColor(),
		image_alpha);
	
	shader_reset();
}

{
	gpu_set_blendmode(bm_normal);
	gpu_set_alphatestenable(true);

	var coords = sprite_get_uvs(sprite_index, image_index);
	var wind_factor = 0.0;
	shader_set(sh_normalTreeWiggle);
	shader_set_uniform_f(u_spriteCoords, coords[0], coords[1], coords[2], coords[3]);
	shader_set_uniform_f(u_spriteTexelCount, sprite_get_width(sprite_index), sprite_get_height(sprite_index));
	shader_set_uniform_f(u_animationValues, current_time / 1000.0, sin(current_time / 1000.0), wind_factor, id % 314);
	
	//draw_self();
	draw_sprite_ext(sprite_index, image_index,
					x, y,
					image_xscale, image_yscale, image_angle,
					image_blend, image_alpha);
	
	shader_reset();
}