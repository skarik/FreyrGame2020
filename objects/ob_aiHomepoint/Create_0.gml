/// @description Create the initial state

if (exists(m_character))
{
	if (m_character.object_index == o_chRoboCrab)
	{
		m_character.xstart = x;
		m_character.ystart = y;
	}
}