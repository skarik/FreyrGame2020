var inventory = o_PlayerTest.inventory;

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
}

//
// Perform select/cancel logic:
if (o_PlayerTest.m_usingInventory)
{
	// Nothing is selected...
	if (m_belt_selection == null && m_bag_selection == null && m_seed_selection == null)
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
		}
	}
	// If a bag object selected:
	else if (m_belt_selection == null && m_bag_selection != null && m_seed_selection == null)
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
		}
		else if (o_PlayerTest.cancelButton.pressed)
		{	// Cancel selection
			m_bag_selection = null;
		}
	}
	// If a seed object selected:
	else if (m_belt_selection == null && m_bag_selection == null && m_seed_selection != null)
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
		}
		else if (o_PlayerTest.cancelButton.pressed)
		{	// Cancel selection
			m_seed_selection = null;
		}
	}
	// If a belt object selected:
	else if (m_belt_selection != null && m_bag_selection == null && m_seed_selection == null)
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
		}
		else if (o_PlayerTest.cancelButton.pressed)
		{	// Cancel selection
			m_belt_selection = null;
		}
	}
}
