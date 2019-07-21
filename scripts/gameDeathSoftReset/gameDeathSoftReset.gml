with (o_PlayerTest)
{
	m_isDead = false;
	x = xstart;
	y = ystart;
	
	if (room != rm_oasis_farm)
	{
		room_goto(rm_oasis_farm);
	}
	
	stats.m_health = ceil(stats.m_healthMax * 0.4);
}