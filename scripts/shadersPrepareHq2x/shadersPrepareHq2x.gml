/// @function shadersPrepareHq2x(sprite_index)
/// @param sprite_index

var sprite = argument0;
var s_bbox = sprite_get_uvs(sprite, 0);

var s_w = sprite_get_width(sprite) * s_bbox[6];
var s_h = sprite_get_height(sprite) * s_bbox[7];

shader_set_uniform_f(global.sh_hq2x_u_spriteSize, s_w, s_h);
shader_set_uniform_f(global.sh_hq2x_u_spriteUVs, s_bbox[0], s_bbox[1], s_bbox[2], s_bbox[3]);

if (!surface_exists(global.sh_hq2x_surface))
{
	var blendmode = gpu_get_blendmode_ext();

	global.sh_hq2x_surface = surface_create(sprite_get_width(s_effect_hq2xLUT), sprite_get_height(s_effect_hq2xLUT));
	surface_set_target(global.sh_hq2x_surface);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	draw_sprite(s_effect_hq2xLUT, 0, 0, 0);
	surface_reset_target();
	
	gpu_set_blendmode_ext(blendmode[0], blendmode[1]);
}

texture_set_stage(global.sh_hq2x_samplerHQXLut, surface_get_texture(global.sh_hq2x_surface));