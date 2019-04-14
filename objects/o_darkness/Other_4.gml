/// @description clear the D A R K n E S S

if (surface_exists(m_darkness))
{
	surface_set_target(m_darkness);
	draw_clear_alpha(c_black, 1.0);
	surface_reset_target();
}