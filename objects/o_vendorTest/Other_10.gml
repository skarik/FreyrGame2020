/// @description Open the inventory

if (iexists(m_user) && m_user.id == o_PlayerTest.id)
{
	// tell the inventory to look at this inventory
	o_PlayerTest.m_currentVendor = id;
	o_PlayerTest.m_usingInventory = false;
	o_PlayerTest.m_usingBook = false;
}