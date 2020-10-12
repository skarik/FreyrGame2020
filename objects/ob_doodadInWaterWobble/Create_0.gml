/// @description Set wiggle speeds

// Inherit the parent event
event_inherited();

wiggle_x_mod = random_range(0.8, 1.2);
wiggle_y_mod = random_range(0.8, 1.2);

m_x_float = 0;
m_y_float = 0;
function depthWorldDraw_DoodadInWaterWobble()
{
	draw_sprite_ext(
		sprite_index, image_index,
		x + m_x_float, y + m_y_float,
		image_xscale, image_yscale,
		image_angle, image_blend, image_alpha);
}
function depthShadowPredraw_DoodadInWaterWobble()
{
	m_x_float = round(sin(current_time * 0.00176 * wiggle_x_mod + id) * 1.1);
	m_y_float = round(cos(current_time * 0.00233 * wiggle_y_mod + id) * 0.5 + 0.5);
}
function depthShadowDraw_DoodadInWaterWobble()
{
	var height = sprite_get_height(sprite_index);
	var shadowOffset = ceil(height / 64.0);
	var shadowClip = ceil(height / 4.0);
	
	// Draw Shadow B
	draw_sprite_part_ext(
		sprite_index, image_index,
		0, 0,
		sprite_get_width(sprite_index), sprite_yoffset,
		x - sprite_xoffset + m_x_float, y - sprite_yoffset + sprite_yoffset + height * 0.5 + m_y_float,
		image_xscale, -image_yscale * 0.5,
		shadowSillohuetteColor(),
		image_alpha);
	
	// Draw the water occlusion
	draw_sprite_part_ext(
		sprite_index, image_index,
		0, height - shadowClip,
		sprite_get_width(sprite_index), shadowClip,
		x - sprite_xoffset + m_x_float, y + shadowOffset - sprite_yoffset + (height - shadowClip) + m_y_float,
		image_xscale, image_yscale,
		waterOcclusionColor(),
		image_alpha);
}
depthSetWorldDrawFunction(depthWorldDraw_DoodadInWaterWobble);
depthSetShadowDrawFunction(depthShadowDraw_DoodadInWaterWobble);
depthSetShadowDrawFunction(depthShadowDraw_DoodadInWaterWobble);