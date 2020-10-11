/// @description Set up far shadow

// Inherit the parent event
event_inherited();

function depthShadowDraw_DoodadWindmillSpinner()
{
	var matx_world_prev = matrix_get(matrix_world);
	var matx_squash = matrix_build(0,0,0, 0,0,0, 1.0, 0.5, 1.0);
	var matx_world_squashed = matrix_multiply(matx_squash, matx_world_prev);
	matrix_set(matrix_world, matx_world_squashed);
	draw_sprite_ext(
		sprite_index, image_index,
		x, (y + 240 + 80) / 0.5,
		image_xscale, -image_yscale, -image_angle,
		shadowSillohuetteColor(),
		image_alpha);
	matrix_set(matrix_world, matx_world_prev);
}
depthSetShadowDrawFunction(depthShadowDraw_DoodadWindmillSpinner);
depthSetWorldDrawFunction(depthWorldDrawSelfNoHeight);