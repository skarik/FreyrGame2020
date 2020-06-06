with (o_PlayerTest)
{
	m_isKOed = false;
	/*x = xstart;
	y = ystart;
	
	if (room != rm_oasis_farm)
	{
		room_goto(rm_oasis_farm);
	}*/
	playerCheckpointLoad();
	
	// load from the save file
	stats.m_health = ceil(stats.m_healthMax * 0.4);
}

gameRespawnEnemies(kRespawnEnemeiesMinor);