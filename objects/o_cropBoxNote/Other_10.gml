/// @description Display the note

if (exists(m_user) && m_user.id == o_PlayerTest.id)
{
	if (!exists(ob_CtsTalker))
	{
		Cts_MakeGabber(m_user, "Self", "\"Place goods into the box on the right. In the morning, I'll take them to town, and put items traded for into the left box.\"");
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		new(o_CtsReenablePlayerOnCtsEnd);
	}
}