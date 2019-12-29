/// @description Add item to player inventory

if (input_addItem)
{
	debugOut("Adding item to the player inventory...");

	with (input_actor)
	{
		debugOut("Performing fallback add...");
	
		m_pickupTarget = getPlayer();
		var inventory = m_pickupTarget.inventory;
	
		// TODO: Add to the TOOL/SKILL belt instead.
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
										m_onUiScript,
										m_type,
										m_tradeItem,
										m_userInfo, m_userInfoString);
								
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
											m_onUiScript,
											m_type,
											m_tradeItem,
											m_userInfo, m_userInfoString);
			}

			// If item is not null by the end...
			if (item != null)
			{
				event_inherited(); // Destroy self & play effects
			}
		}

		// Otherwise, we drop.
		m_isPickingUp = false;
	}
}

// Then we delete it
delete(input_actor);