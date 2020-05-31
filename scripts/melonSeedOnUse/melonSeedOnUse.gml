var _itemType = argument0;

if (iexists(m_plant_dirt))
{
	m_plant_dirt.planted = true;
	
	var plant = instance_create_depth(m_plant_x, m_plant_y, 5, o_cropMelon);
	//plant.m_dirt = m_plant_dirt;
	plant.m_startHour = timeofdayGetHour();
	plant.m_startDay = timeofdayGetDay();
	
	_playerInteractItemDecrementBelt();
	
	// Play animation
	m_isPlanting = true;
	m_plant_timer = 0.0;
}