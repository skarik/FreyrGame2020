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

// Update sprites
if (iexists(m_vendor))
{
	m_vendorPortraitSprite = m_vendor.m_vendorPortrait;
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
		if (m_tradeenabled && m_buttongs[?"hover"] == VendorButtons.Trade)
		{
			// TODO: check the value of things
			vendorKickItemsBackTo(m_itemarray_tx, m_vendor.m_inventory.item, false);
			vendorKickItemsBackTo(m_itemarray_rx, m_player.inventory.bag, true);
		}
	}
	
	// update vendor trading values
	if (array_any_not(m_itemarray_tx, null))
	{
		m_tradevalue_tx = 0;
		for (var i = 0; i < array_length_1d(m_itemarray_tx); ++i)
		{
			var item = m_itemarray_tx[i];
			if (item.object != null)
			{
				var temp_item = inew(item.object);
				temp_item.visible = false;
				{
					m_tradevalue_tx += temp_item.m_worthInGears * item.count;
				}
				idelete(temp_item);
			}
		}
	}
	else
	{
		m_tradevalue_tx = 0;
	}
	if (array_any_not(m_itemarray_rx, null))
	{
		m_tradevalue_rx = 0;
		for (var i = 0; i < array_length_1d(m_itemarray_rx); ++i)
		{
			var item = m_itemarray_rx[i];
			if (item.object != null)
			{
				var temp_item = inew(item.object);
				temp_item.visible = false;
				{
					m_tradevalue_rx += temp_item.m_worthInGears * item.count;
				}
				idelete(temp_item);
			}
		}
	}
	else
	{
		m_tradevalue_rx = 0;
	}
	
	m_tradebalance = (m_tradevalue_rx - m_tradevalue_tx) / max(0.1, min(abs(m_tradevalue_tx), abs(m_tradevalue_rx)));
	m_tradebalance = clamp(m_tradebalance, -1.0, 1.0);
	if (abs(m_tradevalue_tx) >= 0.1
		|| abs(m_tradevalue_rx) >= 0.1)
	{
		// then we can have a proper trade go on
		m_tradeenabled = (m_tradebalance < 0.2);
	}
	else
	{
		m_tradeenabled = false;
	}
	
	
	// do the visual for the trade balance
	var l_tradebalance_visual_velocity = (m_tradebalance_visual - m_tradebalance_visual_previous) / Time.deltaTime;
	//l_tradebalance_visual_velocity -= sign(l_tradebalance_visual_velocity) * min(abs(l_tradebalance_visual_velocity), 14.0 * Time.deltaTime);
	l_tradebalance_visual_velocity -= sign(l_tradebalance_visual_velocity) * min(abs(l_tradebalance_visual_velocity), max(1.0, abs(l_tradebalance_visual_velocity) * 1.4) * Time.deltaTime);
	l_tradebalance_visual_velocity += (m_tradebalance - m_tradebalance_visual) * 50.0 * Time.deltaTime;
	
	m_tradebalance_visual_previous = m_tradebalance_visual;
	
	m_tradebalance_visual += l_tradebalance_visual_velocity * Time.deltaTime;
	m_tradebalance_visual = clamp(m_tradebalance_visual, -1.1, 1.1);
	
	// negative favors other person
	// m_tradebalance < -0.95, gift
	// m_tradebalance > +0.95, free
	// m_tradebalance > +0.2 underpaying
	// m_tradebalance < -0.2 overpaying
	// abs(m_tradebalance) < 0.1, tolerable
	// abs(m_tradebalance) < 0.05, fair
	
	
}