/// @description Update projection

if (!surface_exists(m_bufferProjection))
{
	m_bufferProjection = surface_create(abs(m_projectionRight - m_projectionLeft),
										abs(m_projectionTop - m_projectionBottom));
}

surface_set_target(m_bufferProjection);

draw_clear_alpha(c_black, 1.0);

// draw the screen:
if (m_projectionSprite == null)
{
	draw_set_color(c_white);
	draw_rectangle(0,
				   0,
				   abs(m_projectionRight - m_projectionLeft),
				   abs(m_projectionTop - m_projectionBottom),
				   false);
}
else
{
	draw_sprite_ext(m_projectionSprite, m_projectionSpriteIndex,
					0, 0,
					abs(m_projectionRight - m_projectionLeft) / sprite_get_width(m_projectionSprite),
					abs(m_projectionTop - m_projectionBottom) / sprite_get_height(m_projectionSprite),
					0.0, c_white, 1.0);
}
// draw the player:
gpu_set_tex_filter(true);
var projector = id;
with (getPlayer())
{
	var scale = (projector.y - projector.m_targetBase.y) / (projector.y - y);
	var yblend = 1.0 / scale;
	var line_x = lerp(projector.x, projector.m_targetBase.x, yblend);
	//var line_y = lerp(projector.y, projector.m_targetBase.y, yblend);
	var delta_x = x - line_x;
	
	if (scale > 0.0)
	{
		draw_sprite_ext(sprite_index, image_index,
						abs(projector.m_projectionLeft - projector.m_projectionRight) / 2.0 + delta_x * scale,
						abs(projector.m_projectionTop - projector.m_projectionBottom) - projector.m_projectionBottom,
						scale, scale,
						image_angle,
						c_black,
						1.0);
	}
}
gpu_set_tex_filter(false);
surface_reset_target();