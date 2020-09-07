function generalYeetableOnUse(argument0) {
	var itemType = argument0;

	/*if (iexists(m_plant_dirt))
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
	}*/

	/*var projectile = instance_create_depth(x, y, depth - 1, ob_projectileYeetedItem);
		projectile.z = z;
		projectile.z_height = 24;
		projectile.m_itemObject = itemType;
		projectile.xspeed = lengthdir_x(350, aimingDirection);
		projectile.yspeed = lengthdir_y(350, aimingDirection);
		projectile.m_owner = id;
		projectile.m_team = m_team;

	_playerInteractItemDecrementBelt();*/

	if (moScriptOverride != _playerMoYeetChargeup
		&& moScriptOverride != _playerMoYeetPayload)
	{
		// Go to the throwing movestate
		m_moveCharge = 0.0;
		m_moveChargeItem = itemType;
		moScriptOverride = _playerMoYeetChargeup;
	}


}
