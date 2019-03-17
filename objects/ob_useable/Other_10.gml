/// @description Default inspection

if (exists(m_user) && m_user.id == o_PlayerTest.id)
{
	if (!exists(ob_CtsTalker))
	{
		Cts_MakeGabber(m_user, "Self", "It's a $b" + m_name + "$$.");
		with (m_user) controlZero(true);
	}
}