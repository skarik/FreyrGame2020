/// @description Set up rendering

// Inherit the parent event
event_inherited();

//function depthWorldDraw_DoodadInWater()
//{
//	depthWorldDrawSelf();
//}
function depthShadowDraw_DoodadInWater()
{
	var height = sprite_get_height(sprite_index);
	var shadowOffset = ceil(height / 64.0);
	var shadowClip = ceil(height / 4.0);
	
	// Draw Shadow B
	draw_sprite_part_ext(
		sprite_index, image_index,
		0, 0,
		sprite_get_width(sprite_index), sprite_yoffset,
		x - sprite_xoffset, y - sprite_yoffset + sprite_yoffset + height * 0.5,
		image_xscale, -image_yscale * 0.5,
		shadowSillohuetteColor(),
		image_alpha);
	
	// Draw the water occlusion
	draw_sprite_part_ext(
		sprite_index, image_index,
		0, height - shadowClip,
		sprite_get_width(sprite_index), shadowClip,
		x - sprite_xoffset, y + shadowOffset - sprite_yoffset + (height - shadowClip),
		image_xscale, image_yscale,
		waterOcclusionColor(),
		image_alpha);
}
//depthSetWorldDrawFunction(depthWorldDraw_DoodadInWater);
depthSetShadowDrawFunction(depthShadowDraw_DoodadInWater);