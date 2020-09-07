function aiGobboSquad_OnNewSquad() {

	var new_squad_size = array_length_1d(m_aiGobbo_squad);
	if (m_aiGobbo_squadManage_LastSize != new_squad_size)
	{
		m_aiGobbo_squadManage_LastSize = new_squad_size;

		// Reset the anim stuff
		moAnimationExternal = false;
		for (var i = 0; i < new_squad_size; ++i)
		{
			var gobbo = m_aiGobbo_squad[i];
			if (iexists(gobbo))
				gobbo.moAnimationExternal = false;
		}

		// We want a new position
		m_aiGobbo_squadManage_PositionTimer = -1;

		// Select random attacker when the squad changes
		m_aiGobbo_squadManage_Attacker = floor(random(new_squad_size));
	}


}
