///@function _playerUiGeneralInventoryInputs(holderItemArray, itemArrayArray, hoverArray)
///@param holderItemArray {array}
///@param itemArrayArray {array}
///@param hoverArray {array}
///@returns Inventory last worked on.
function _playerUiGeneralInventoryInputs(argument0, argument1, argument2) {

	var holderItemArray = argument0;
	var itemArrayArray = argument1;
	var hoverArray = argument2;

	// Get current hovered index & inventory
	var l_inventory = null;
	var l_inventory_selection = null;
	for (var i = 0; i < array_length_1d(itemArrayArray); ++i)
	{
		if (hoverArray[i] != null)
		{
			l_inventory = itemArrayArray[i];
			l_inventory_selection = hoverArray[i];
		}
	}

	var l_held_inventory = holderItemArray;
	
	// If any item selected:
	if (o_PlayerTest.selectButton.pressed && l_inventory != null)
	{
		// Are the items in the hand & slot the same?
		if (l_held_inventory[0].object != null && l_held_inventory[0].object == l_inventory[l_inventory_selection].object)
		{
			// Get max stack of the item
			var max_stack = 10;
			{
				var temp_item = inew(l_held_inventory[0].object);
				max_stack = temp_item.m_maxStack;
				idelete(temp_item);
			}
			
			// If the inventory one is at special length, only add one to the hand
			if (l_inventory[l_inventory_selection].count == kCountPositiveInfinite)
			{
				l_held_inventory[0].count = min(l_held_inventory[0].count + 1, max_stack);
			}
			// Combine the stacks if the inventory one is not at max
			else if (l_inventory[l_inventory_selection].count < max_stack)
			{
				var transfer_amount = min(max_stack - l_inventory[l_inventory_selection].count, l_held_inventory[0].count);
				l_held_inventory[0].count -= transfer_amount;
				l_inventory[l_inventory_selection].count += transfer_amount;
			}
			// If the inventory slot at max, then swap the hand and item
			else
			{
				itemEntrySwap(l_held_inventory[0], l_inventory[l_inventory_selection]);
			}
		}
		// Is our hand empty and the item in the inventory has a special count?
		else if (l_held_inventory[0].object == null && l_inventory[l_inventory_selection].object != null && l_inventory[l_inventory_selection].count == kCountPositiveInfinite)
		{
			// Grab exactly one of the item. Next clicks will fall into above stacking case.
			itemEntryCopy(l_held_inventory[0], l_inventory[l_inventory_selection]);
			l_held_inventory[0].count = 1;
		}
		// Base case, just swap items from the hand
		else if (l_inventory[l_inventory_selection].count != kCountPositiveInfinite)
		{
			itemEntrySwap(l_held_inventory[0], l_inventory[l_inventory_selection]);
		}
		// Bad case, cannot do thing, spit annoying sound
		else
		{
			audio_play_sound(snd_UIOnUse, 0, false);
		}
	}
	// If any item is secondary-actioned:
	if (o_PlayerTest.actUiButton.pressed && l_inventory != null)
	{
		// Are the items in the hand & slot the same?
		if (l_held_inventory[0].object != null && l_held_inventory[0].object == l_inventory[l_inventory_selection].object)
		{
			// Get max stack of the item
			var max_stack = 10;
			{
				var temp_item = inew(l_held_inventory[0].object);
				max_stack = temp_item.m_maxStack;
				idelete(temp_item);
			}
		
			// Decrease current by one if inventory one is infinite
			if (l_inventory[l_inventory_selection].count == kCountPositiveInfinite)
			{
				l_held_inventory[0].count -= 1;
			}
			// Combine the stacks incrementally if the inventory one is not at max
			else if (l_inventory[l_inventory_selection].count < max_stack)
			{
				var transfer_amount = min(max_stack - l_inventory[l_inventory_selection].count, 1);
				l_held_inventory[0].count -= transfer_amount;
				l_inventory[l_inventory_selection].count += transfer_amount;
			}
		}
		// Is it an empty slot we're depositing into?
		else if (l_held_inventory[0].object != null && l_inventory[l_inventory_selection].object == null)
		{
			itemEntryCopy(l_inventory[l_inventory_selection], l_held_inventory[0]);
			l_inventory[l_inventory_selection].count = 0;
			
			var transfer_amount = 1;
			l_held_inventory[0].count -= transfer_amount;
			l_inventory[l_inventory_selection].count += transfer_amount;
		}
		// Base case, just split stacks (rounded up) from the inventory
		else if (l_held_inventory[0].object == null && l_inventory[l_inventory_selection].object != null)
		{
			// Splitting from infinite, only grab one
			if (l_inventory[l_inventory_selection].count == kCountPositiveInfinite)
			{
				itemEntryCopy(l_held_inventory[0], l_inventory[l_inventory_selection]);
				l_held_inventory[0].count = 1;
			}
			// Base case, just split stacks (rounded up) from the inventory
			else
			{
				itemEntryCopy(l_held_inventory[0], l_inventory[l_inventory_selection]);
				l_held_inventory[0].count = 0;
			
				var transfer_amount = ceil(l_inventory[l_inventory_selection].count / 2);
				l_held_inventory[0].count += transfer_amount;
				l_inventory[l_inventory_selection].count -= transfer_amount;
			}
		}
		// Bad case, cannot do thing, spit annoying sound
		else
		{
			audio_play_sound(snd_UIOnUse, 0, false);
		}
	}
	
	// Clean up slots as needed since we've been dirty
	if (l_held_inventory[0].count == 0)
	{
		itemEntryClear(l_held_inventory[0]);
	}
	if (l_inventory != null && l_inventory[l_inventory_selection].count == 0)
	{
		itemEntryClear(l_inventory[l_inventory_selection]);
	}

	return l_inventory;


}
