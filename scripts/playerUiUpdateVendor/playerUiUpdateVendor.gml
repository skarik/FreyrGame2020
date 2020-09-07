function playerUiUpdateVendor() {

	if (m_player.m_currentVendor != null)
	{
		inew_unique(o_menuVendorTrading);
	}

	if (iexists(o_menuVendorTrading))
	{
		m_vendor_totalBlend = o_menuVendorTrading.m_totalBlend;
	}
	else
	{
		m_vendor_totalBlend = max(0.0, m_vendor_totalBlend - Time.unscaledDeltaTime * 3.0);
	}



}
