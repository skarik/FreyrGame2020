/// @function vendorKickItemsBackTo(item_array_from, item_array_to, drop_on_ground)
/// @param item_array_from
/// @param item_array_to
/// @param drop_on_ground {Boolean}
function vendorKickItemsBackTo(argument0, argument1, argument2) {
	var item_array_from = argument0;
	var item_array_to = argument1;
	var drop_on_ground = argument2;

	// todo: consolidate stacks of items


	// get all items we can in the space we can
	var current_slot = -1;
	var spitting_to_ground = false;
	for (var i = 0; i < array_length_1d(item_array_from); ++i)
	{
		if (!spitting_to_ground)
		{
			// First, find a proper slot in the target inventory
			while (current_slot < array_length_1d(item_array_to)
				&& (current_slot == -1 || item_array_to[current_slot].object != null))
			{
				++current_slot;
			}
			// If we out of space, then we gotta switch to kick-out mode
			if (current_slot >= array_length_1d(item_array_to))
			{
				spitting_to_ground = true;
			}
			// Otherwise, we just shuffle it to the inventory
			else
			{
				itemEntrySwap(item_array_from[i], item_array_to[current_slot]);
				continue;
			}
		}
	
		// Kick the item to the ground
		if (spitting_to_ground)
		{
			if (drop_on_ground)
			{
				itemEntryInstantiate(m_player.x, m_player.y, item_array_from[i]);
			}
			itemEntryClear(item_array_from[i]);
		}
	}


}
