/// @description Insert description here
// You can write your code in this editor

var height = sprite_get_height(sprite_index);
var shadowOffset = ceil(height / 64.0);
var shadowClip = ceil(height / 4.0);

gpu_set_alphatestenable(false);
gpu_set_blendenable(true);
gpu_set_blendmode_ext(bm_dest_color, bm_zero);

shader_set(sh_colormaskAlphatest); // shader_set is slow as FUCK

// Draw the shadow 1
draw_sprite_part_ext(
	sprite_index, image_index,
	0, height - shadowClip,
	sprite_get_width(sprite_index), shadowClip,
	x - sprite_xoffset, y + shadowOffset - sprite_yoffset + (height - shadowClip),
	image_xscale, image_yscale,
	shadowOcclusionColor(),
	image_alpha);
// Draw the shadow 2
draw_sprite_part_ext(
	sprite_index, image_index,
	0, 0,
	sprite_get_width(sprite_index), sprite_yoffset,
	x - sprite_xoffset, y - sprite_yoffset + sprite_yoffset + height * 0.5,
	image_xscale, -image_yscale * 0.5,
	shadowSillohuetteColor(),
	image_alpha);
	
shader_reset();

{
	gpu_set_blendmode(bm_normal);
	gpu_set_alphatestenable(true);
	
	var coords;
	var wind_factor = 0.0;
	
	// draw the back leaves
	shader_set(sh_normalTreeWiggle);
	shader_set_uniform_f(u_spriteTexelCount, sprite_get_width(sprite_index), sprite_get_height(sprite_index));
	shader_set_uniform_f(u_animationValues, Time.time, sin(Time.time), wind_factor, id % 314);
	coords = sprite_get_uvs(sprite_index, 2);
	shader_set_uniform_f(u_spriteCoords, coords[0], coords[1], coords[2], coords[3]);
	draw_sprite_ext(sprite_index, 2,
					x, y,
					image_xscale, image_yscale, image_angle,
					image_blend, image_alpha);
	shader_reset();
	
	// draw trunk
	draw_sprite_ext(sprite_index, 1,
					x, y,
					image_xscale, image_yscale, image_angle,
					image_blend, image_alpha);
					
	// draw top leaves	
	shader_set(sh_normalTreeWiggle);
	shader_set_uniform_f(u_spriteTexelCount, sprite_get_width(sprite_index), sprite_get_height(sprite_index));
	shader_set_uniform_f(u_animationValues, Time.time, sin(Time.time), wind_factor, (id * 1.4) % 413);
	coords = sprite_get_uvs(sprite_index, 3);
	shader_set_uniform_f(u_spriteCoords, coords[0], coords[1], coords[2], coords[3]);
	draw_sprite_ext(sprite_index, 3,
					x + 1.4 * sin(Time.time / 1.1 + (id * 3.79) % 167), y,
					image_xscale, image_yscale, image_angle,
					image_blend, image_alpha);
	coords = sprite_get_uvs(sprite_index, 4);
	shader_set_uniform_f(u_spriteCoords, coords[0], coords[1], coords[2], coords[3]);
	shader_set_uniform_f(u_animationValues, Time.time, sin(Time.time), wind_factor, (id * 1.3) % 279);
	draw_sprite_ext(sprite_index, 4,
					x + 1.4 * sin(Time.time / 0.9 + (id * 4.13) % 179), y,
					image_xscale, image_yscale, image_angle,
					image_blend, image_alpha);
	shader_reset();
}