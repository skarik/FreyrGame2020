/// @description inventoryCopyAddItem(inventory, item)
/// @param inventory : inventory to edit
/// @param item : item to add to the inventory

var inventory = argument0;
var itemToAdd = argument1;

// Normal mode!
if (inventory.item_count != kCountInfinite)
{
	// loop through the inventory and find the first open position
	for (var i = 0; i < inventory.item_count; ++i)
	{
		if (inventory.item[i].object == null)
		{
			itemEntryCopy(inventory.item[i], itemToAdd);
			return inventory.item[i];
		}
	}
	return null;
}
// Infinite mode!
else
{
	// loop through the inventory and find the first open position
	var array_length = array_length_1d(inventory.item);
	for (var i = 0; i < array_length; ++i)
	{
		if (inventory.item[i].object == null)
		{
			itemEntryCopy(inventory.item[i], itemToAdd);
			return inventory.item[i];
		}
	}
	inventory.item[array_length] = itemEntryNew();
	itemEntryCopy(inventory.item[array_length], itemToAdd);
	return inventory.item[array_length];
}