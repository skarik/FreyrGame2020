if (exists(m_plant_dirt))
{
	m_plant_dirt.planted = true;
	
	instance_create_depth(m_plant_x, m_plant_y, 5, o_cropTurnip);
	
	_playerInteractItemDecrementBelt();
}