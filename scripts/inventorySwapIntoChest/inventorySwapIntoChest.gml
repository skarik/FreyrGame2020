/// @description inventorySwapIntoChest(inventory, spot, item)
/// @param inventory : Inventory to check the count of the item array
/// @param spot : Place to swap into
/// @param item : Item being swapped into

var inventory = argument0;
var spot = argument1;
var new_item = argument2;
if (exists(inventory))
{
	// Need to add a new item
	if (spot >= inventoryGetCount(inventory))
	{
		if (inventoryGetSize(inventory) == kCountInfinite)
		{
			// select the last open spot
			spot = inventoryGetCount(inventory);
			inventory.item[spot] = itemEntryNew();
			itemEntrySwap(inventory.item[spot], new_item);
		}
		else
		{
			show_error("invalid call to the swap-into-chest", true);
		}
	}
	else
	{
		// just swap normally
		itemEntrySwap(inventory.item[spot], new_item);
	}
}

return 0;

/*
inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_hover,
					inventory.bag[m_bag_selection]);*/
					
					