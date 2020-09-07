function playerUiUpdateInventoryManagement() {
	var inventory = o_PlayerTest.inventory;
	var chest = o_PlayerTest.m_currentChest;

	// update the controls for unified keyboard selection
	if (o_PlayerTest.m_usingInventory)
	{
		// Perform directional controls
		if (o_PlayerTest.uvPositionStyle == kControlUvStyle_Unused && o_PlayerTest.m_prevInventoryActive == true)
		{
			var uv_info = playerUiControlCollectUV();
			var prevAxis = uv_info[0];
			var currAxis = uv_info[1];
			var prevAxisMagnitude = uv_info[2];
			var currAxisMagnitude = uv_info[3];
			var prevAxisNormalized = uv_info[4];
			var currAxisNormalized = uv_info[5];
			var axisDirectionChange = uv_info[6];
		
			// Generate the selection control
			var inventoryArray = null;
			inventoryArray = array_concat(m_belt_draw_rects, m_chest_draw_rects);
			if (!m_sbag_seeds)
				inventoryArray = array_concat(inventoryArray, m_bag_draw_rects);
			else
				inventoryArray = array_concat(inventoryArray, m_seed_draw_rects);
		
			// Create the current selection index
			var current_selection = null;
			if (m_bag_hover != null)
				current_selection = array_length_1d(m_belt_draw_rects) + array_length_1d(m_chest_draw_rects) + m_bag_hover;
			else if (m_seed_hover != null)
				current_selection = array_length_1d(m_belt_draw_rects) + array_length_1d(m_chest_draw_rects) + m_seed_hover;
			else if (m_chest_hover != null)
				current_selection = array_length_1d(m_belt_draw_rects) + m_chest_hover;
			else if (m_belt_hover != null)
				current_selection = m_belt_hover;
			else
				current_selection = array_length_1d(m_belt_draw_rects) + array_length_1d(m_chest_draw_rects);
		
			// Update the selection
			var prev_selection = current_selection;
			current_selection = playerUiControlSelectFromArray(uv_info, current_selection, inventoryArray, 8.0);
		
			if (current_selection != prev_selection)
			{
				m_belt_hover = null;
				m_chest_hover = null;
				m_bag_hover = null;
				m_seed_hover = null;
			}
		
			// Turn the linear selection into the correct inventory selection
			if (current_selection < array_length_1d(m_belt_draw_rects))
				m_belt_hover = current_selection;
			else if (current_selection < array_length_1d(m_belt_draw_rects) + array_length_1d(m_chest_draw_rects))
				m_chest_hover = current_selection - array_length_1d(m_belt_draw_rects);
			else if (!m_sbag_seeds)
				m_bag_hover = current_selection - array_length_1d(m_belt_draw_rects) - array_length_1d(m_chest_draw_rects);
			else
				m_seed_hover = current_selection - array_length_1d(m_belt_draw_rects) - array_length_1d(m_chest_draw_rects);
		}
	
	}

	if (o_PlayerTest.m_usingInventory)
		o_PlayerTest.m_prevInventoryActive = true;	
	else
		o_PlayerTest.m_prevInventoryActive = false;

	// update sbag automatically based on the selected object in the belt
	if (o_PlayerTest.m_usingInventory)
	{
		if (m_belt_selection != null && inventory.belt[m_belt_selection].object != null)
		{
			if (inventory.belt[m_belt_selection].type == kItemPickupSeed)
			{
				m_sbag_seeds = true;
			}
			else
			{
				m_sbag_seeds = false;
			}
		}
		// do the same with chests
		if (chest != null && m_chest_selection != null
			&& m_chest_selection < inventoryGetCount(chest)
			&& chest.item[m_chest_selection].object != null)
		{
			if (chest.item[m_chest_selection].type == kItemPickupSeed)
			{
				m_sbag_seeds = true;
			}
			else
			{
				m_sbag_seeds = false;
			}
		}
	}

	//
	// Perform select/cancel logic:
	if (o_PlayerTest.m_usingInventory)
	{
		_playerUiGeneralInventoryInputs(m_held_inventory,
										[inventory.belt, inventory.bag, inventory.seed, o_PlayerTest.m_currentChest],
										[m_belt_hover, m_bag_hover, m_seed_hover, m_chest_hover]);
	
		// Allow for swapping bags in general
		if (o_PlayerTest.prevUiButton.pressed || o_PlayerTest.nextUiButton.pressed)
		{	// allow for swapping bags while nothing is selected
			m_sbag_seeds = !m_sbag_seeds;
		}
	
		// Force certain bags depending on the item currently held
		if (m_held_inventory[0].object != null)
		{
			if (m_held_inventory[0].type == kItemPickupSeed)
			{
				m_sbag_seeds = true;
			}
			else
			{
				m_sbag_seeds = false;
			}
		}
	}



}
