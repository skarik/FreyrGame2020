var inventory = o_PlayerTest.inventory;

//
// Perform select/cancel logic:
if (o_PlayerTest.m_usingInventory)
{
	// Nothing is selected...
	if (m_bag_selection == null && m_belt_selection == null)
	{
		if (o_PlayerTest.selectButton.pressed)
		{	
			// Set up selection
			m_bag_selection = m_bag_hover;
			m_belt_selection = m_belt_hover;
		}
	}
	// If a bag object selected:
	else if (m_bag_selection != null && m_belt_selection == null)
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
	// If a belt object selected:
	else if (m_bag_selection == null && m_belt_selection != null)
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
