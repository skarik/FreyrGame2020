/// @description Display the note

if (exists(m_user) && m_user.id == o_PlayerTest.id)
{
	if (!exists(ob_CtsTalker))
	{
		Cts_MakeGabber(m_user, "Self", m_note_message);
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		new(o_CtsReenablePlayerOnCtsEnd);
	}
}