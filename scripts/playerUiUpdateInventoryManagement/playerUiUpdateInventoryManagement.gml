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
	// Get current hovered index & inventory
	var l_inventory = null;
	var l_inventory_selection = null;
	if (m_belt_hover != null)
	{
		l_inventory = inventory.belt;
		l_inventory_selection = m_belt_hover;
	}
	else if (m_bag_hover != null)
	{
		l_inventory = inventory.bag;
		l_inventory_selection = m_bag_hover;
	}
	else if (m_seed_hover != null)
	{
		l_inventory = inventory.seed;
		l_inventory_selection = m_seed_hover;
	}
	else if (m_chest_hover != null)
	{
		l_inventory = o_PlayerTest.m_currentChest;
		l_inventory_selection = m_chest_hover;
	}
	
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
	
	// If any item selected:
	if (o_PlayerTest.selectButton.pressed && l_inventory != null)
	{
		// Are the items in the hand & slot the same?
		if (m_held_inventory[0].object != null && m_held_inventory[0].object == l_inventory[l_inventory_selection].object)
		{
			// Get max stack of the item
			var max_stack = 10;
			{
				var temp_item = inew(m_held_inventory[0].object);
				max_stack = temp_item.m_maxStack;
				idelete(temp_item);
			}
			
			// If the inventory one is at special length, only add one to the hand
			if (l_inventory[l_inventory_selection].count == kCountPositiveInfinite)
			{
				m_held_inventory[0].count = min(m_held_inventory[0].count + 1, max_stack);
			}
			// Combine the stacks if the inventory one is not at max
			else if (l_inventory[l_inventory_selection].count < max_stack)
			{
				var transfer_amount = min(max_stack - l_inventory[l_inventory_selection].count, m_held_inventory[0].count);
				m_held_inventory[0].count -= transfer_amount;
				l_inventory[l_inventory_selection].count += transfer_amount;
			}
			// If the inventory slot at max, then swap the hand and item
			else
			{
				itemEntrySwap(m_held_inventory[0], l_inventory[l_inventory_selection]);
			}
		}
		// Is our hand empty and the item in the inventory has a special count?
		else if (m_held_inventory[0].object == null && l_inventory[l_inventory_selection].object != null && l_inventory[l_inventory_selection].count == kCountPositiveInfinite)
		{
			// Grab exactly one of the item. Next clicks will fall into above stacking case.
			itemEntryCopy(m_held_inventory[0], l_inventory[l_inventory_selection]);
			m_held_inventory[0].count = 1;
		}
		// Base case, just swap items from the hand
		else
		{
			itemEntrySwap(m_held_inventory[0], l_inventory[l_inventory_selection]);
		}
	}
	// If any item is secondary-actioned:
	if (o_PlayerTest.actUiButton.pressed && l_inventory != null)
	{
		// Are the items in the hand & slot the same?
		if (m_held_inventory[0].object != null && m_held_inventory[0].object == l_inventory[l_inventory_selection].object)
		{
			// Get max stack of the item
			var max_stack = 10;
			{
				var temp_item = inew(m_held_inventory[0].object);
				max_stack = temp_item.m_maxStack;
				idelete(temp_item);
			}
			
			// Combine the stacks incrementally if the inventory one is not at max
			if (l_inventory[l_inventory_selection].count < max_stack)
			{
				var transfer_amount = min(max_stack - l_inventory[l_inventory_selection].count, 1);
				m_held_inventory[0].count -= transfer_amount;
				l_inventory[l_inventory_selection].count += transfer_amount;
			}
		}
		// Is it an empty slot we're depositing into?
		else if (m_held_inventory[0].object != null && l_inventory[l_inventory_selection].object == null)
		{
			itemEntryCopy(l_inventory[l_inventory_selection], m_held_inventory[0]);
			l_inventory[l_inventory_selection].count = 0;
			
			var transfer_amount = 1;
			m_held_inventory[0].count -= transfer_amount;
			l_inventory[l_inventory_selection].count += transfer_amount;
		}
		// Base case, just split stacks (rounded up) from the inventory
		else if (m_held_inventory[0].object == null && l_inventory[l_inventory_selection].object != null)
		{
			itemEntryCopy(m_held_inventory[0], l_inventory[l_inventory_selection]);
			m_held_inventory[0].count = 0;
			
			var transfer_amount = ceil(l_inventory[l_inventory_selection].count / 2);
			m_held_inventory[0].count += transfer_amount;
			l_inventory[l_inventory_selection].count -= transfer_amount;
		}
	}
	
	// Clean up slots as needed since we've been dirty
	if (m_held_inventory[0].count == 0)
	{
		itemEntryClear(m_held_inventory[0]);
	}
	if (l_inventory != null && l_inventory[l_inventory_selection].count == 0)
	{
		itemEntryClear(l_inventory[l_inventory_selection]);
	}
	
	// Nothing is selected...
	/*if (m_belt_selection == null && m_bag_selection == null && m_seed_selection == null && m_chest_selection == null)
	{
		if (o_PlayerTest.prevUiButton.pressed || o_PlayerTest.nextUiButton.pressed)
		{	// allow for swapping bags while nothing is selected
			m_sbag_seeds = !m_sbag_seeds;
		}
		if (o_PlayerTest.selectButton.pressed)
		{	
			// Set up selection
			m_belt_selection = m_belt_hover;
			m_bag_selection = m_sbag_seeds ? null : m_bag_hover;
			m_seed_selection = m_sbag_seeds ? m_seed_hover : null;
			m_chest_selection = m_chest_hover;
		}
		// todo: if nothing is selected, hide the bags
		if(o_PlayerTest.cancelButton.pressed)
		{
			//Close the inventory
			o_PlayerTest.m_usingInventory = false;
		}
	}
	// If a bag object selected:
	else if (m_belt_selection == null && m_bag_selection != null && m_seed_selection == null && m_chest_selection == null)
	{
		if (o_PlayerTest.selectButton.pressed)
		{
			if (m_belt_hover != null)
			{	// Swap with the belt
				itemEntrySwap(
					inventory.belt[m_belt_hover],
					inventory.bag[m_bag_selection]);
				m_bag_selection = null;
			}
			else if (m_bag_hover != null)
			{	// Swap within bag
				itemEntrySwap(
					inventory.bag[m_bag_hover],
					inventory.bag[m_bag_selection]);
				m_bag_selection = null;
			}
			else if (m_chest_hover != null)
			{	// Swap with the chest
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_hover,
					inventory.bag[m_bag_selection]);
				m_bag_selection = null;
			}
		}
		else if (o_PlayerTest.cancelButton.pressed)
		{	// Cancel selection
			m_bag_selection = null;
		}
	}
	// If a seed object selected:
	else if (m_belt_selection == null && m_bag_selection == null && m_seed_selection != null && m_chest_selection == null)
	{
		if (o_PlayerTest.selectButton.pressed)
		{
			if (m_belt_hover != null)
			{	// Swap with the belt
				itemEntrySwap(
					inventory.belt[m_belt_hover],
					inventory.seed[m_seed_selection]);
				m_seed_selection = null;
			}
			else if (m_seed_hover != null)
			{	// Swap within bag
				itemEntrySwap(
					inventory.seed[m_seed_hover],
					inventory.seed[m_seed_selection]);
				m_seed_selection = null;
			}
			else if (m_chest_hover != null)
			{	// Swap with the chest
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_hover,
					inventory.seed[m_seed_selection]);
				m_seed_selection = null;
			}
		}
		else if (o_PlayerTest.cancelButton.pressed)
		{	// Cancel selection
			m_seed_selection = null;
		}
	}
	// If a belt object selected:
	else if (m_belt_selection != null && m_bag_selection == null && m_seed_selection == null && m_chest_selection == null)
	{
		if (o_PlayerTest.selectButton.pressed)
		{
			if (m_bag_hover != null)
			{	// Swap with the bag
				itemEntrySwap(
					inventory.bag[m_bag_hover],
					inventory.belt[m_belt_selection]);
				m_belt_selection = null;
			}
			else if (m_seed_hover != null)
			{	// Swap with the seed bag
				itemEntrySwap(
					inventory.seed[m_seed_hover],
					inventory.belt[m_belt_selection]);
				m_belt_selection = null;
			}
			else if (m_belt_hover != null)
			{	// Swap within belt
				itemEntrySwap(
					inventory.belt[m_belt_hover],
					inventory.belt[m_belt_selection]);
				m_belt_selection = null;
			}
			else if (m_chest_hover != null)
			{	// Swap with the chest
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_hover,
					inventory.belt[m_belt_selection]);
				m_belt_selection = null;
			}
		}
		else if (o_PlayerTest.cancelButton.pressed)
		{	// Cancel selection
			m_belt_selection = null;
		}
	}
	// If a chest object is selected:
	else if (m_belt_selection == null && m_bag_selection == null && m_seed_selection == null && m_chest_selection != null)
	{
		if (o_PlayerTest.selectButton.pressed)
		{
			if (m_bag_hover != null)
			{	// Swap with the bag
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_selection,
					inventory.bag[m_bag_hover]);
				m_chest_selection = null;
			}
			else if (m_seed_hover != null)
			{	// Swap with the bag
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_selection,
					inventory.seed[m_seed_hover]);
				m_chest_selection = null;
			}
			else if (m_belt_hover != null)
			{	// Swap with the bag
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_selection,
					inventory.belt[m_belt_hover]);
				m_chest_selection = null;
			}
			else if (m_chest_hover != null && m_chest_hover < inventoryGetCount(chest))
			{	// Swap with the bag
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_selection,
					chest.item[m_chest_hover]);
				m_chest_selection = null;
			}
		}
		else if (o_PlayerTest.cancelButton.pressed)
		{	// Cancel selection
			m_chest_selection = null;
		}
	}*/
}
