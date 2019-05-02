/// @description inventoryGetSize(inventory)
/// @param inventory : Inventory to check the size

var inventory = argument0;
if (exists(inventory))
{
	return inventory.item_count;
}

return 0;