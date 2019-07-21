/*
// Set up squad stuff
m_aiGobbo_squadSize = 0;
m_aiGobbo_squadLeader = null;
m_aiGobbo_squadMember = null;
m_aiGobbo_squad = array_create(0);
*/

#region Update Squad

// Look for a squad leader if we don't have one
if (!exists(m_aiGobbo_squadLeader) || m_aiGobbo_squadLeader.m_isDead)
{
	// If we have a squad, select a new leader
	if (array_length_1d(m_aiGobbo_squad) != 0)
	{
		for (var i = 0; i < array_length_1d(m_aiGobbo_squad); ++i)
		{
			if (exists(m_aiGobbo_squad[i]))
			{
				m_aiGobbo_squadLeader = m_aiGobbo_squad[i];
				break;
			}
		}
		aiGobboSquad_SetLeader(m_aiGobbo_squadLeader, m_aiGobbo_squad);
	}
	// If we have no squad, find a squad
	else
	{
		aiGobboSquad_CreateSquad();
		aiGobboSquad_SetLeader(id, m_aiGobbo_squad);
		
		// Zero out the squad age
		for (var i = 0; i < array_length_1d(m_aiGobbo_squad); ++i)
		{
			if (exists(m_aiGobbo_squad[i]))
			{
				m_aiGobbo_squad[i].m_aiGobbo_squadAge = 0.0;
			}
		}
	}
}
else
{
	// Refresh squad every N amount of time
	if (m_aiGobbo_squadAge > 1.0)
	{
		// Zero out the squad age every N amount of time so only self can update
		for (var i = 0; i < array_length_1d(m_aiGobbo_squad); ++i)
		{
			if (exists(m_aiGobbo_squad[i]))
			{
				m_aiGobbo_squad[i].m_aiGobbo_squadAge = 0.0;
			}
		}
		// Find a new squad:
		aiGobboSquad_CreateSquad();
		aiGobboSquad_SetLeader(id, m_aiGobbo_squad);
	}
	m_aiGobbo_squadAge += Time.deltaTime;
}

#endregion

#region Squad Leader Gives Commands



#endregion