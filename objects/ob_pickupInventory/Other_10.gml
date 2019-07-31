/// @description Add to the inventory if possible

// Drop if picked up by invalid object
if (!exists(m_pickupTarget))
{
	m_isPickingUp = false;
	exit;
}

var inventory = m_pickupTarget.inventory;

//if (m_type != kItemPickupResource)
{
	var item;
	item = itemArrayAddItemProp(inventory.belt,
								object_index,
								1,
								m_maxStack,
								m_name,
								m_checkUseScript,
								m_onUseScript,
								m_onDepleteScript,
								m_type);
								
	// todo: add shit to bag
	if (item == null)
	{
		// add to either bag or seeds
		item = itemArrayAddItemProp(m_type == kItemPickupSeed ? inventory.seed : inventory.bag,
									object_index,
									1,
									m_maxStack,
									m_name,
									m_checkUseScript,
									m_onUseScript,
									m_onDepleteScript,
									m_type);
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
