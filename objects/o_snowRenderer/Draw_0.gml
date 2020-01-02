/// @description Copy-pasta the snow onto the map

if (surface_exists(m_snowBuffer))
{
	shader_set(sh_bufferedSnow);
	shader_set_uniform_f(uSnowTexelSize,
						 1.0 / surface_get_width(m_snowBuffer), 1.0 / surface_get_height(m_snowBuffer));
	
	draw_surface(m_snowBuffer, 0, 0);
	shader_reset();
}