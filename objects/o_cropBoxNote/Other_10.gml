/// @description Display the note

if (iexists(m_user) && m_user.id == o_PlayerTest.id)
{
	if (!iexists(ob_CtsTalker))
	{
		ctsMakeGabber(m_user, "Self", "\"Place goods into the box on the right. In the morning, I'll take them to town, and put items traded for into the left box.\"");
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		inew(o_CtsReenablePlayerOnCtsEnd);
	}
}