var new_leader = argument0;
var squad_list = argument1;

// Create the array of squad
m_aiGobbo_squad = array_create(0);
m_aiGobbo_squad[0] = new_leader;
for (var i = 0; i < array_length_1d(squad_list); ++i)
{
	if (squad_list[i] != new_leader && iexists(squad_list[i]))
	{
		m_aiGobbo_squad[array_length_1d(m_aiGobbo_squad)] = squad_list[i];
	}
}

// Loop through the squad and set the variables
var source_gobbo = id;
for (var i = 0; i < array_length_1d(m_aiGobbo_squad); ++i)
{
	with (m_aiGobbo_squad[i])
	{
		m_aiGobbo_squad = source_gobbo.m_aiGobbo_squad;
		m_aiGobbo_squadMember = i;
		m_aiGobbo_squadLeader = source_gobbo.m_aiGobbo_squad[0];
		m_aiGobbo_squadSize = array_length_1d(m_aiGobbo_squad);
		
		// Update squad infoes
		aiGobboSquad_OnNewSquad();
	}
}