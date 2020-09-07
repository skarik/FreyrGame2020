/// @description inventoryGetSize(inventory)
/// @param inventory : Inventory to check the size
function inventoryGetSize(argument0) {

	var inventory = argument0;
	if (iexists(inventory))
	{
		return inventory.item_count;
	}

	return 0;


}
