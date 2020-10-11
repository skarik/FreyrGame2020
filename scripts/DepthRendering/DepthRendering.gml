function depthWorldDrawSelf()
{
	var dx, dy;
	dx = round(x);
	dy = round(y);
	draw_sprite_ext(sprite_index, image_index,
					dx, round(dy - z_height),
					image_xscale, image_yscale,
					image_angle,
					image_blend,
					image_alpha);
}
function depthShadowPredrawNone() {}
function depthShadowDrawNone() {}


function depthShadowPredrawCircle10()
{
	m_shadowDrawPercent = max(0.75, sprite_height / 32.0);
	m_shadowDrawPercent /= (1.0 + max(0.0, z_height) / 32.0);
}
function depthShadowDrawCircle10()
{
	var dx, dy;
	dx = round(x);
	dy = round(y);
	var shadow_w = m_shadowDrawPercent * 6.0;
	var shadow_h = m_shadowDrawPercent * 2.0;

	draw_sprite_ext(
		slt_shadow_24x8, 0,
		floor(dx), floor(dy),
		shadow_w / 12, shadow_h / 4,
		0.0,
		shadowSillohuetteColor(),
		image_alpha);
}


function depthShadowPredrawCircle2p5()
{
	m_shadowDrawPercent = max(0.25, sprite_height / 32.0) * 0.25;
	m_shadowDrawPercent /= (1.0 + max(0.0, z_height) / 32.0);
	m_shadowDrawPercent *= min(1.0, max(0.0, z_height) / 4.0);
}


function depthShadowDrawPropShadow()
{
	var height = sprite_get_height(sprite_index);
	var shadowOffset = ceil(height / 64.0);
	var shadowClip = ceil(height / 4.0);
	
	// Draw Shadow A
	draw_sprite_part_ext(
		sprite_index, image_index,
		0, height - shadowClip,
		sprite_get_width(sprite_index), shadowClip,
		x - sprite_xoffset, y + shadowOffset - sprite_yoffset + (height - shadowClip),
		image_xscale, image_yscale,
		shadowOcclusionColor(),
		image_alpha);
	
	// Draw Shadow B
	draw_sprite_part_ext(
		sprite_index, image_index,
		0, 0,
		sprite_get_width(sprite_index), sprite_yoffset,
		x - sprite_xoffset, y - sprite_yoffset + sprite_yoffset + height * 0.5,
		image_xscale, -image_yscale * 0.5,
		shadowSillohuetteColor(),
		image_alpha);
}