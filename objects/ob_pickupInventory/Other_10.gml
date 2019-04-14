/// @description Add to the inventory if possible

// Drop if picked up by invalid object
if (!exists(m_pickupTarget))
{
	m_isPickingUp = false;
	exit;
}

var inventory = m_pickupTarget.inventory;

// Loop through the player inventory, add if find a matching item
for (var i = 0; i < inventory.belt_size; ++i)
{
	if (inventory.belt_object[i] == object_index)
	{
		if (inventory.belt_count[i] < m_maxStack)
		{
			inventory.belt_count[i] += 1;
			inventory.belt_name[i] = m_name;
			inventory.belt_checkUse[i] = m_checkUseScript;
			inventory.belt_onUse[i] = m_onUseScript;
			inventory.belt_type[i] = m_type;
			event_inherited(); // Destroy self & play effects
			exit;
		}
	}
}

// Otherwise, look for an empty spot
for (var i = 0; i < inventory.belt_size; ++i)
{
	if (inventory.belt_object[i] == null)
	{
		inventory.belt_object[i] = object_index;
		inventory.belt_count[i] = 1;
		inventory.belt_name[i] = m_name;
		inventory.belt_checkUse[i] = m_checkUseScript;
		inventory.belt_onUse[i] = m_onUseScript;
		inventory.belt_type[i] = m_type;
		event_inherited(); // Destroy self & play effects
		exit;
	}
}

// Otherwise, we drop.
m_isPickingUp = false;
exit;
