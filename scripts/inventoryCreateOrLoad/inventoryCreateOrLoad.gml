/// @description inventoryCreateOrLoad(name, size)
/// @param name : Can be null
/// @param size : requests size of inventory 

var l_name = argument0;
var l_size = argument1;
var l_inventory = null;

// If the name is not null...
if (l_name != null)
{
	// Search through all the currently existing inventories
	with (ob_inventoryChest)
	{
		if (name == l_name) // Does the name match? if So, continue
		{
			l_inventory = this;
			break;
		}
	}
}

// TODO: If iventory doesnt exist, load from the disk
if (l_inventory == null)
{
	// Load from disk
}

// Create a new inventory if it doesn't exist
if (l_inventory == null)
{
	l_inventory = new(ob_inventoryChest);
	l_inventory.persistent = true;
	l_inventory.name = (l_name == null) ? inventory.name : l_name;
	
	l_inventory.item_count = l_size;
	l_inventory.item = itemArrayCreate(l_size);
}

return l_inventory;