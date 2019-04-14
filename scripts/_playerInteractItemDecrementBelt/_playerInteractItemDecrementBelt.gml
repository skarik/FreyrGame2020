
inventory.belt_count[inventory.belt_selection] -= 1;

// Clear out the inventory if used up entirely.
if (inventory.belt_count[inventory.belt_selection] <= 0)
{
	inventory.belt_count[inventory.belt_selection] = 0;
	inventory.belt_object[inventory.belt_selection] = null;
	inventory.belt_name[inventory.belt_selection] = "";
	inventory.belt_type[inventory.belt_selection] = kItemPickupNormal;
}