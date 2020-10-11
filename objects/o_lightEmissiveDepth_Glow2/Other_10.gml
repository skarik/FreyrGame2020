/// @description draw sprite with depth

if (!color_setup)
{
	m_color = color_multiply(target.image_blend, image_blend);
	color_setup = true;
}

if (mask)
	shader_set(sh_colormaskAlphatest);
	
draw_set_color(c_white);
draw_sprite_ext(target.sprite_index, target.image_index,
				target.x + xoffset, target.y - target.z_height + yoffset,
				target.image_xscale, target.image_yscale,
				target.image_angle,
				m_color,
				target.image_alpha * image_alpha);
				
var draw_offsets_x = [-1, +1, 0,  0,
					  -1, -2, -1,  0, +1, +2, +1,  0];
var draw_offsets_y = [ 0,  0, -1, +1,
					  -1,  0, +1, +2, +1,  0, -1, -2];
var draw_offsets_a = [0.15, 0.15, 0.15, 0.15,
					  0.10, 0.05, 0.10, 0.05, 0.10, 0.05, 0.10, 0.05];

for (var i = 0; i < 12; ++i)
{
	draw_sprite_ext(target.sprite_index, target.image_index,
					target.x + xoffset + draw_offsets_x[i],
					target.y - target.z_height + yoffset + draw_offsets_y[i],
					target.image_xscale, target.image_yscale,
					target.image_angle,
					m_color,
					target.image_alpha * image_alpha * draw_offsets_a[i]);
}
				
if (mask)
	shader_reset();
/*	
var blur_pass_1 = surface_create(sprite_get_width(target.sprite_index), sprite_get_height(target.sprite_index));
var blur_pass_2 = surface_create(sprite_get_width(target.sprite_index), sprite_get_height(target.sprite_index));

surface_set_target(blur_pass_1);
draw_clear_alpha(c_black, 0.0);
draw_sprite_ext(target.sprite_index, target.image_index,
				sprite_get_xoffset(target.sprite_index),
				sprite_get_yoffset(target.sprite_index),
				1.0, 1.0, 0.0, c_white, 1.0);
surface_reset_target();

gpu_set_blendmode_ext(bm_one, bm_zero);
shader_set(sh_7tapBlurFilter);
	surface_set_target(blur_pass_2);
	shader_set_uniform_f(uBlurPixelInfo, 2.0 / surface_get_width(blur_pass_1), 0.0);
	draw_clear_alpha(c_black, 0.0);
	draw_surface(blur_pass_1, 0, 0);
	surface_reset_target();
	
	surface_set_target(blur_pass_1);
	shader_set_uniform_f(uBlurPixelInfo, 0.0, 2.0 / surface_get_height(blur_pass_2));
	draw_clear_alpha(c_black, 0.0);
	draw_surface(blur_pass_2, 0, 0);
	surface_reset_target();
shader_reset();

lightingResetBlendMode();
//draw_surface(blur_pass_1, target.x, target.y);
repeat(3)
{
draw_surface_ext(blur_pass_1,
				  target.x + xoffset,
				  target.y + yoffset,
				  target.image_xscale, target.image_yscale,
				  target.image_angle,
				  color_multiply(target.image_blend, image_blend),
				  target.image_alpha * image_alpha);
}

surface_free(blur_pass_1);
surface_free(blur_pass_2);
*/