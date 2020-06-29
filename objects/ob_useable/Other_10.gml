/// @description On use - Default inspection

if (m_usable && iexists(m_user) && m_user.id == o_PlayerTest.id)
{
	if (!ctsGabbersHaveFocus())
	{
		ctsMakeGabber(m_user, "Self", "It's a $b" + m_name + "$$.");
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		inew(o_CtsReenablePlayerOnCtsEnd);
	}
}