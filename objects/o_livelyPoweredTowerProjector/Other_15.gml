/// @description Draw glowing bits

if (surface_exists(m_bufferProjection))
{
	draw_surface(m_bufferProjection,
				 m_targetBase.x + m_projectionLeft + xoffset,
				 m_targetBase.y + m_projectionTop  + yoffset);
}