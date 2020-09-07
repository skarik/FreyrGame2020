function playerUiDrawVendor() {
	if (!iexists(o_menuVendorTrading)) exit;

	surface_reset_target();
	surface_set_target(m_surface);

	with (o_menuVendorTrading) event_user(kEvent_UnifiedDraw6);


}
