/// @description Get shader uniforms

// Inherit the parent event
event_inherited();

u_spriteCoords = shader_get_uniform(sh_normalTreeWiggle, "u_spriteCoords");
u_spriteTexelCount = shader_get_uniform(sh_normalTreeWiggle, "u_spriteTexelCount");
u_animationValues = shader_get_uniform(sh_normalTreeWiggle, "u_animationValues");

shadow_enabled = true;


function depthWorldDraw_DoodadTreeWiggle()
{
	gpu_set_blendmode(bm_normal);
	gpu_set_alphatestenable(true);

	var coords = sprite_get_uvs(sprite_index, image_index);
	var wind_factor = 0.0;
	shader_set(sh_normalTreeWiggle);
	shader_set_uniform_f(u_spriteCoords, coords[0], coords[1], coords[2], coords[3]);
	shader_set_uniform_f(u_spriteTexelCount, sprite_get_width(sprite_index), sprite_get_height(sprite_index));
	shader_set_uniform_f(u_animationValues, Time.time, sin(Time.time), wind_factor, id % 314);
	
	draw_sprite_ext(sprite_index, image_index,
					x, y,
					image_xscale, image_yscale, image_angle,
					image_blend, image_alpha);
	
	shader_reset();
}

depthSetWorldDrawFunction(depthWorldDraw_DoodadTreeWiggle);
depthSetShadowDrawFunction(depthShadowDrawPropShadow);
