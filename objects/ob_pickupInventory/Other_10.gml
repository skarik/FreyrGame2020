/// @description Add to the inventory if possible

// Drop if picked up by invalid object
if (!iexists(m_pickupTarget))
{
	m_isPickingUp = false;
	exit;
}

var inventory = m_pickupTarget.inventory;

//if (m_type != kItemPickupResource)
{
	var item;
	item = pickupAddToArray(inventory.belt);
	
	// todo: add shit to bag
	if (item == null)
	{
		// add to either bag or seeds
		item = pickupAddToArray(m_type == kItemPickupSeed ? inventory.seed : inventory.bag);
	}

	// If item is not null by the end...
	if (item != null)
	{
		event_inherited(); // Destroy self & play effects
	}
}

// Otherwise, we drop.
m_isPickingUp = false;
exit;
