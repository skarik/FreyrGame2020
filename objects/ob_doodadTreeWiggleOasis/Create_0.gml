/// @description Get shader uniforms

// Inherit the parent event
event_inherited();

u_spriteCoords = shader_get_uniform(sh_normalTreeWiggle, "u_spriteCoords");
u_spriteTexelCount = shader_get_uniform(sh_normalTreeWiggle, "u_spriteTexelCount");
u_animationValues = shader_get_uniform(sh_normalTreeWiggle, "u_animationValues");