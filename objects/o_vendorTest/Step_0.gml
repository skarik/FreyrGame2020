/// @description Update with character

if (m_hasCharacter)
{
	if (!iexists(m_character))
	{
		x = -1000;
		y = -1000;
		if (iexists(m_characterObjectIndex))
		{
			m_character = instance_find(m_characterObjectIndex, 0);
			if (m_character.m_interactionObject != id)
			{
				idelete(m_character.m_interactionObject);
				m_character.m_interactionObject = id;
			}
		}
	}
	else
	{
		x = m_character.x;
		y = m_character.y;
	}
}