/// @description Capture the current screen for glitch base

if (surface_exists(Screen.m_gameSurface))
{
	m_glitchBaseBuffer = surface_create(surface_get_width(Screen.m_gameSurface), surface_get_height(Screen.m_gameSurface));
	surface_copy(m_glitchBaseBuffer, 0, 0, Screen.m_gameSurface);
	
	m_glitchBaseX = GameCamera.view_x;
	m_glitchBaseY = GameCamera.view_y;
}