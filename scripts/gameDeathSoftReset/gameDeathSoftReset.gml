with (o_PlayerTest)
{
	m_isDead = false;
	x = xstart;
	y = ystart;
	
	if (room != rm_oasis)
	{
		room_goto(rm_oasis);
	}
	
	stats.m_health = ceil(stats.m_healthMax * 0.4);
}