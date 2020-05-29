/// @description Create the initial state

if (iexists(m_character))
{
	if (m_character.object_index == o_chRoboCrab)
	{
		m_character.xstart = x;
		m_character.ystart = y;
		m_character.m_aiHomeDistance = point_distance(m_character.x, m_character.y, x, y);
	}
}