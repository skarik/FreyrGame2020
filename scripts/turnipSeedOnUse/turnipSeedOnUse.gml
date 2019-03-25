if (exists(m_plant_dirt))
{
	m_plant_dirt.planted = true;
	
	var plant = instance_create_depth(m_plant_x, m_plant_y, 5, o_cropTurnip);
	plant.m_dirt = m_plant_dirt;
	
	_playerInteractItemDecrementBelt();
}