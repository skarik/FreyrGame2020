/// @description draw light ray

if (m_lightBuffer == null || !surface_exists(m_lightBuffer))
	event_user(8);
	
draw_surface_ext(m_lightBuffer,
				 x + xoffset - m_lightBufferOriginX,
				 y + yoffset - m_lightBufferOriginY,
				 1.0, 1.0,
				 0.0,
				 image_blend,
				 image_alpha);