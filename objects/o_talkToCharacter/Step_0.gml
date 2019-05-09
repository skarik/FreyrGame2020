/// @description Update params and sprite

if (m_owner != null)
{
	m_name = m_owner.m_name;
	sprite_index = m_owner.mask_index;
	x = m_owner.x;
	y = m_owner.y;
}

if (m_interacting)
{
	if (cutsceneIsChoiceReady())
	{
		m_interacting = false;
		var choice = cutsceneGetChoice();
		if (choice == 0)
		{
			Cts_MakeGabber(m_owner, m_owner.m_name, "Hello to you as well!");
		}
		else if (choice == 1)
		{
			Cts_MakeGabber(m_owner, m_owner.m_name, "Okay...");
			m_owner.m_aiFollowing = false;
		}
		else if (choice == 2)
		{
			Cts_MakeGabber(m_owner, m_owner.m_name, "What do you want me to make?");
		}
	}
}