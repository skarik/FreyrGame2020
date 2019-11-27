if (exists(m_plant_dirt))
{
	m_plant_dirt.planted = true;
	
	var plant_object = inventory.belt[inventory.belt_selection].userInfo;
	
	var plant = instance_create_depth(m_plant_x, m_plant_y, 5, plant_object);
	//plant.m_dirt = m_plant_dirt;
	plant.m_startHour = timeofdayGetHour();
	plant.m_startDay = timeofdayGetDay();
	with (plant) event_user(1); // Hide on timer
	
	_playerInteractItemDecrementBelt();
	
	// Play animation
	m_isPlanting = true;
	m_plant_timer = 0.0;
}