/// @description Draw in screenspace
surface_set_target(Screen.m_gameSurface);

_talkerDraw();

surface_reset_target();