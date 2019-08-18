var inventory = o_PlayerTest.inventory;
var chest = o_PlayerTest.m_currentChest;

// update sbag automatically based on the selected object in the belt
if (o_PlayerTest.m_usingInventory)
{
	if (m_belt_selection != null && inventory.belt[m_belt_selection].object != null)
	{
		if (inventory.belt[m_belt_selection].type == kItemPickupSeed)
		{
			m_sbag_seeds = true;
		}
		else
		{
			m_sbag_seeds = false;
		}
	}
	// do the same with chests
	if (chest != null && m_chest_selection != null
		&& m_chest_selection < inventoryGetCount(chest)
		&& chest.item[m_chest_selection].object != null)
	{
		if (chest.item[m_chest_selection].type == kItemPickupSeed)
		{
			m_sbag_seeds = true;
		}
		else
		{
			m_sbag_seeds = false;
		}
	}
}

//
// Perform select/cancel logic:
if (o_PlayerTest.m_usingInventory)
{
	// Nothing is selected...
	if (m_belt_selection == null && m_bag_selection == null && m_seed_selection == null && m_chest_selection == null)
	{
		if (o_PlayerTest.prevUiButton.pressed || o_PlayerTest.nextUiButton.pressed)
		{	// allow for swapping bags while nothing is selected
			m_sbag_seeds = !m_sbag_seeds;
		}
		if (o_PlayerTest.selectButton.pressed)
		{	
			// Set up selection
			m_belt_selection = m_belt_hover;
			m_bag_selection = m_sbag_seeds ? null : m_bag_hover;
			m_seed_selection = m_sbag_seeds ? m_seed_hover : null;
			m_chest_selection = m_chest_hover;
		}
		// todo: if nothing is selected, hide the bags
		if(o_PlayerTest.cancelButton.pressed)
		{
			//Close the inventory
			o_PlayerTest.m_usingInventory = false;
		}
	}
	// If a bag object selected:
	else if (m_belt_selection == null && m_bag_selection != null && m_seed_selection == null && m_chest_selection == null)
	{
		if (o_PlayerTest.selectButton.pressed)
		{
			if (m_belt_hover != null)
			{	// Swap with the belt
				itemEntrySwap(
					inventory.belt[m_belt_hover],
					inventory.bag[m_bag_selection]);
				m_bag_selection = null;
			}
			else if (m_bag_hover != null)
			{	// Swap within bag
				itemEntrySwap(
					inventory.bag[m_bag_hover],
					inventory.bag[m_bag_selection]);
				m_bag_selection = null;
			}
			else if (m_chest_hover != null)
			{	// Swap with the chest
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_hover,
					inventory.bag[m_bag_selection]);
				m_bag_selection = null;
			}
		}
		else if (o_PlayerTest.cancelButton.pressed)
		{	// Cancel selection
			m_bag_selection = null;
		}
	}
	// If a seed object selected:
	else if (m_belt_selection == null && m_bag_selection == null && m_seed_selection != null && m_chest_selection == null)
	{
		if (o_PlayerTest.selectButton.pressed)
		{
			if (m_belt_hover != null)
			{	// Swap with the belt
				itemEntrySwap(
					inventory.belt[m_belt_hover],
					inventory.seed[m_seed_selection]);
				m_seed_selection = null;
			}
			else if (m_seed_hover != null)
			{	// Swap within bag
				itemEntrySwap(
					inventory.seed[m_seed_hover],
					inventory.seed[m_seed_selection]);
				m_seed_selection = null;
			}
			else if (m_chest_hover != null)
			{	// Swap with the chest
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_hover,
					inventory.seed[m_seed_selection]);
				m_seed_selection = null;
			}
		}
		else if (o_PlayerTest.cancelButton.pressed)
		{	// Cancel selection
			m_seed_selection = null;
		}
	}
	// If a belt object selected:
	else if (m_belt_selection != null && m_bag_selection == null && m_seed_selection == null && m_chest_selection == null)
	{
		if (o_PlayerTest.selectButton.pressed)
		{
			if (m_bag_hover != null)
			{	// Swap with the bag
				itemEntrySwap(
					inventory.bag[m_bag_hover],
					inventory.belt[m_belt_selection]);
				m_belt_selection = null;
			}
			else if (m_seed_hover != null)
			{	// Swap with the seed bag
				itemEntrySwap(
					inventory.seed[m_seed_hover],
					inventory.belt[m_belt_selection]);
				m_belt_selection = null;
			}
			else if (m_belt_hover != null)
			{	// Swap within belt
				itemEntrySwap(
					inventory.belt[m_belt_hover],
					inventory.belt[m_belt_selection]);
				m_belt_selection = null;
			}
			else if (m_chest_hover != null)
			{	// Swap with the chest
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_hover,
					inventory.belt[m_belt_selection]);
				m_belt_selection = null;
			}
		}
		else if (o_PlayerTest.cancelButton.pressed)
		{	// Cancel selection
			m_belt_selection = null;
		}
	}
	// If a chest object is selected:
	else if (m_belt_selection == null && m_bag_selection == null && m_seed_selection == null && m_chest_selection != null)
	{
		if (o_PlayerTest.selectButton.pressed)
		{
			if (m_bag_hover != null)
			{	// Swap with the bag
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_selection,
					inventory.bag[m_bag_hover]);
				m_chest_selection = null;
			}
			else if (m_seed_hover != null)
			{	// Swap with the bag
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_selection,
					inventory.seed[m_seed_hover]);
				m_chest_selection = null;
			}
			else if (m_belt_hover != null)
			{	// Swap with the bag
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_selection,
					inventory.belt[m_belt_hover]);
				m_chest_selection = null;
			}
			else if (m_chest_hover != null && m_chest_hover < inventoryGetCount(chest))
			{	// Swap with the bag
				inventorySwapIntoChest(
					o_PlayerTest.m_currentChest,
					m_chest_selection,
					chest.item[m_chest_hover]);
				m_chest_selection = null;
			}
		}
		else if (o_PlayerTest.cancelButton.pressed)
		{	// Cancel selection
			m_chest_selection = null;
		}
	}
}
