/// @description Set up specific shadow rendering

// Inherit the parent event
event_inherited();

function depthShadowDraw_DoodadModularBuilding()
{
	var height = sprite_get_height(sprite_index);
	var shadowOffset = ceil(height / 64.0);
	var shadowClip = ceil(height / 4.0);

	// Draw Shadow B
	draw_sprite_ext(
		sprite_index, image_index,
		x, y - 16 * image_yscale,
		image_xscale, image_yscale * -0.25,
		0.0,
		//shadowSillohuetteColor(),
		shadowOcclusionColor(),
		image_alpha);

	// Draw Shadow A
	draw_sprite_part_ext(
		sprite_index, image_index,
		0, height - shadowClip,
		sprite_get_width(sprite_index), shadowClip,
		x - sprite_xoffset, y + shadowOffset - sprite_yoffset + (height - shadowClip),
		image_xscale, image_yscale,
		shadowOcclusionColor(),
		image_alpha);
}
depthSetShadowDrawFunction(depthShadowDraw_DoodadModularBuilding);