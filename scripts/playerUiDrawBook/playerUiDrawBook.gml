if (!iexists(o_menuPlayerBook)) exit;

surface_reset_target();
surface_set_target(m_surface);

with (o_menuPlayerBook) event_user(kEvent_UnifiedDraw6);