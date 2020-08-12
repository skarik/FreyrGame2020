/// @description Vendor update

if (!iexists(m_player))
	m_player = getPlayer();
	
// Menu check:
if (m_player.m_currentVendor != null)
{
	m_totalBlend = min(1.0, m_totalBlend + Time.unscaledDeltaTime * 3.0);
	m_vendor = m_player.m_currentVendor;
}
else
{
	m_totalBlend = max(0.0, m_totalBlend - Time.unscaledDeltaTime * 3.0);
	if (m_totalBlend <= 0.0)
	{
		idelete(this);
		exit; // Skip the rest of the step if deleteed
	}
}

// Only do input if book is front & center
if (m_player.m_currentVendor != null || m_totalBlend == 1.0)
{
	controlUpdate(false);
}
else
{
	controlUpdate(true);
}

// Only do logic if book is front and center
if (m_player.m_currentVendor != null || m_totalBlend == 1.0)
{
	_playeruiVendorStepItemBox(m_boxgs_player, m_boxds_player);
	_playeruiVendorStepItemBox(m_boxgs_vendor, m_boxds_vendor);
	_playeruiVendorStepItemBox(m_boxgs_rx, m_boxds_rx);
	_playeruiVendorStepItemBox(m_boxgs_tx, m_boxds_tx);
	
	_playeruiVendorStepButtons(m_buttongs, m_buttonds);
	
	// click selection needs to consider all states together
	_playeruiVendorStepItemBoxGlobal([m_boxgs_player, m_boxgs_vendor, m_boxgs_rx, m_boxgs_tx],
									 [m_boxds_player, m_boxds_vendor, m_boxds_rx, m_boxds_tx],
									 [m_player.inventory.bag, m_vendor.m_inventory.item, m_itemarray_rx, m_itemarray_tx],
									 [[m_player.inventory.bag, m_itemarray_tx], [m_vendor.m_inventory.item, m_itemarray_rx]],
									 [m_buttongs],
									 [m_buttonds]);
									 
	if (o_PlayerTest.selectButton.pressed)
	{
		if (m_buttongs[?"hover"] == VendorButtons.Leave)
		{
			// halt current trade
			vendorKickItemsBackTo(m_itemarray_tx, m_player.inventory.bag, true);
			vendorKickItemsBackTo(m_itemarray_rx, m_vendor.m_inventory.item, false);
			
			m_player.m_currentVendor = null; // Clear out vendor to close the UI
		}
		if (m_buttongs[?"hover"] == VendorButtons.ClearGive)
		{
			vendorKickItemsBackTo(m_itemarray_tx, m_player.inventory.bag, true);
		}
		if (m_buttongs[?"hover"] == VendorButtons.ClearGet)
		{
			vendorKickItemsBackTo(m_itemarray_rx, m_vendor.m_inventory.item, false);
		}
		if (m_buttongs[?"hover"] == VendorButtons.Trade)
		{
			// TODO: check the value of things
			vendorKickItemsBackTo(m_itemarray_tx, m_vendor.m_inventory.item, false);
			vendorKickItemsBackTo(m_itemarray_rx, m_player.inventory.bag, true);
		}
	}
}