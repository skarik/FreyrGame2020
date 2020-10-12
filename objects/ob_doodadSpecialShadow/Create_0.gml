/// @description Set special shadow up

event_inherited();

shadow_index = null;

function depthShadowDraw_DoodadSpecialShadow()
{
	if (shadow_index != null)
	{
		// Draw special shadow
		draw_sprite_ext(
			shadow_index, image_index,
			x, y,
			image_xscale, image_yscale,
			image_angle,
			shadowSillohuetteColor(),
			image_alpha);
	}
}
depthSetShadowDrawFunction(depthShadowDraw_DoodadSpecialShadow);