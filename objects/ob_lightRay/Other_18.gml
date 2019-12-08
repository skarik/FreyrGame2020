/// @description Render light ray surface

m_lightBufferWidth = sprite_width + abs(lengthdir_x(-m_castDistance, m_castAngle));
m_lightBufferHeight = sprite_height + abs(lengthdir_y(-m_castDistance, m_castAngle));
m_lightBuffer = surface_create(m_lightBufferWidth, m_lightBufferHeight);
m_lightBufferOriginX = 0;
m_lightBufferOriginY = 0;

// Calculate light buffer origin
if (lengthdir_x(-1.0, m_castAngle) < 0.0)
	m_lightBufferOriginX = m_lightBufferWidth - sprite_width + sprite_xoffset - 1;
else
	m_lightBufferOriginX = sprite_xoffset;
	
if (lengthdir_y(-1.0, m_castAngle) < 0.0)
	m_lightBufferOriginY = m_lightBufferHeight - sprite_height + sprite_yoffset - 1;
else
	m_lightBufferOriginY = sprite_xoffset;
	
// Draw the light
surface_set_target(m_lightBuffer);
{
	draw_clear_alpha(c_black, 0.0);
	
	// Base floor cast
	draw_sprite_ext(sprite_index, image_index,
					m_lightBufferOriginX, m_lightBufferOriginY,
					image_xscale, image_yscale,
					image_angle, c_white, 1.0);
					
	// Light ray
	var	offset_percent;
	var offset_basex = lengthdir_x(-1.0, m_castAngle);
	var offset_basey = lengthdir_y(-1.0, m_castAngle);
	for (var i = 1; i < m_castDistance; ++i)
	{
		offset_percent = (i / m_castDistance);
		draw_sprite_ext(sprite_index, image_index,
						m_lightBufferOriginX + offset_basex * i,
						m_lightBufferOriginY + offset_basey * i,
						image_xscale, image_yscale,
						image_angle, c_white, 0.4 * (1.0 - offset_percent));
	}
}
surface_reset_target();