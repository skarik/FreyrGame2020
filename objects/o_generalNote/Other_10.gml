/// @description Display the note

if (iexists(m_user) && m_user.id == o_PlayerTest.id)
{
	if (!iexists(ob_CtsTalker))
	{
		ctsMakeGabber(m_user, "Self", m_note_message);
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		inew(o_CtsReenablePlayerOnCtsEnd);
	}
}