/// @description inventoryGetCount(inventory)
/// @param inventory : Inventory to check the count of the item array
function inventoryGetCount(argument0) {

	var inventory = argument0;
	if (iexists(inventory))
	{
		return array_length_1d(inventory.item);
	}

	return 0;


}
