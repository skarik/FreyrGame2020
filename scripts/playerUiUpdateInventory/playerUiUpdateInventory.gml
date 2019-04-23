var inventory = o_PlayerTest.inventory;

// inventory lerps:
{
	// update the selector
	if (m_inventory_selectorTarget != inventory.belt_selection)
	{
		//if (m_inventory_selectorBlend <= 0.00 || m_inventory_selectorBlend >= 1.00)
		//{
		m_inventory_selectorStart = m_inventory_selector;
		m_inventory_selectorBlend = 0.00;
		//}
		m_inventory_selectorTarget = inventory.belt_selection;
		m_inventory_selectorTimerCd = 1.0;
		
		m_inventory_selectorNameTimerCd = 3.0;
	}
	
	// Move the selector around
	m_inventory_selector = lerp(
		m_inventory_selectorStart, 
		m_inventory_selectorTarget,
		bouncestep(smoothstep(m_inventory_selectorBlend))
		);
	m_inventory_selectorBlend = saturate(m_inventory_selectorBlend + Time.deltaTime * 3.0);
	
	// Cool off the selector
	m_inventory_selectorTimerCd -= Time.deltaTime;
	// Perform that blend for the blender
	if (m_inventory_selectorTimerCd > 0.0)
		m_inventory_selectorBlendCruft = saturate(m_inventory_selectorBlendCruft + Time.deltaTime * 6.0);
	else
		m_inventory_selectorBlendCruft = saturate(m_inventory_selectorBlendCruft - Time.deltaTime * 2.0);
		
	// if name doesn't match, we need to swap names
	if (m_inventory_selectorName != inventory.belt[inventory.belt_selection].name)
	{
		m_inventory_selectorNameTimerCd = -1.0;
		if (m_inventory_selectorNameBlend <= 0.0)
		{
			m_inventory_selectorName = inventory.belt[inventory.belt_selection].name;
			m_inventory_selectorNameTimerCd = 3.0;
		}
	}
	else
	{
		// if we're planting get rid of cooldown
		if (inventory.belt[inventory.belt_selection].type == kItemPickupSeed && o_PlayerTest.m_plantable)
		{
			m_inventory_selectorNameTimerCd = max(m_inventory_selectorNameTimerCd, 2.0);
		}
	}
	
	// Cool off the selector
	m_inventory_selectorNameTimerCd -= Time.deltaTime;
	// Perform that blend for the blender
	if (m_inventory_selectorNameTimerCd > 0.0)
		m_inventory_selectorNameBlend = saturate(m_inventory_selectorNameBlend + Time.deltaTime * 5.0);
	else
		m_inventory_selectorNameBlend = saturate(m_inventory_selectorNameBlend - Time.deltaTime * 5.0);
}

// perform the mouse-over checks
{
	//dx + dspace * i + 15, dy + 15
	var cursor_x = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
	var cursor_y = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));
	
	// reset if mouse move
	if (o_PlayerTest.uPosition != o_PlayerTest.uPositionPrevious
		|| o_PlayerTest.vPosition != o_PlayerTest.vPositionPrevious)
	{
		m_belt_hover = null;
	}
	
	// Update the mouse-over 
	var dspace = 25;
	for (var i = 0; i < 6; ++i)
	{
		var box_x = m_belt_base_x + dspace * i + 5;
		var box_y = m_belt_base_y + 5;
		
		if (cursor_x >= box_x && cursor_x <= box_x + 20
			&& cursor_y >= box_y && cursor_y <= box_y + 20)
		{
			m_belt_hover = i;
			break;
		}
	}
}

// if not in inventory, clear selection
if (!o_PlayerTest.m_usingInventory)
{
	m_belt_selection = null;
}