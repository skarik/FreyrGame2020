/// @description Open the inventory

if (iexists(m_user) && m_user.id == o_PlayerTest.id)
{
	/*if (!iexists(ob_CtsTalker))
	{
		ctsMakeGabber(m_user, "Self", "It's a $b" + m_name + "$$.");
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		inew(o_CtsReenablePlayerOnCtsEnd);
	}*/
	// tell the inventory to look at this inventory
	o_PlayerTest.m_currentVendor = id;
	o_PlayerTest.m_usingInventory = false;
	o_PlayerTest.m_usingBook = false;
}