/// @description On use - Default climb

if (m_usable && iexists(m_user))// && m_user.id == o_PlayerTest.id)
{
	/*if (!ctsGabbersHaveFocus())
	{
		ctsMakeGabber(m_user, "Self", "It's a $b" + m_name + "$$.");
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		inew(o_CtsReenablePlayerOnCtsEnd);
	}*/
	if (m_user.y > y)
	{
		m_user.y += bbox_top - m_user.bbox_bottom;
	}
	else
	{
		m_user.y += bbox_bottom - m_user.bbox_top;
	}
	with (m_user)
	{
		z = collision3_get_highest_position(x, y, z);
	}
}