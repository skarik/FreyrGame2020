/// @description inventory = inventoryCleanup(inventory, compact)
/// @param inventory : Inventory to clean up
/// @param compact : If all empty spaces should be removed

var inventory = argument0;
var compact = argument1;
if (exists(inventory))
{
	if (inventoryGetSize(inventory) != kCountInfinite)
	{
		show_error("invalid call to cleanup inventory", false);
		return inventory;
	}
	
	// Need to shift down all the inventory for every empty spot. We're going to do this the dumb way
	var current_max_check = inventoryGetCount(inventory);
	var current_spots_cleaned = 0;
	
	if (compact)
	{
		for (var i_check = 0; i_check < current_max_check; ++i_check)
		{
			var item = inventory.item[i_check];
			if (item == null || item.object == null)
			{
				current_spots_cleaned += 1;
				for (var i = i_check; i < current_max_check - 1; ++i)
				{
					// Copy it down (to shift it)
					itemEntryCopy(inventory.item[i], inventory.item[i + 1]);
				}
				// Clear out the top item
				itemEntryClear(inventory.item[current_max_check - 1]);
			}
		}
	}
	else
	{	// Only check blank spots at the end
		for (var i_check = current_max_check - 1; i_check > 0; --i_check)
		{
			var item = inventory.item[i_check];
			if (item == null || item.object == null)
			{
				current_spots_cleaned += 1;
			}
			else
			{	// Stop checking if found an item.
				break;
			}
		}
	}
	
	// No need to do anything if no spots to clean
	if (current_spots_cleaned == 0)
	{
		return inventory;
	}
	
	// Now we need a new item array since arrays can only get larger
	var new_items_size = current_max_check - current_spots_cleaned;
	var new_items = itemArrayCreate(new_items_size);
	for (var i = 0; i < new_items_size; ++i)
	{
		itemEntryCopy(new_items[i], inventory.item[i]);
	}
	
	// Clear out old inventory
	itemArrayFree(inventory.item);
	// Set up new item array
	inventory.item = new_items;
	
	// return new inventory
	return inventory;
}

return inventory;