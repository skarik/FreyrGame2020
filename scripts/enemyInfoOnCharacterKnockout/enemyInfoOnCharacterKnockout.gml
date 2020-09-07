/// @function enemyInfoOnCharacterKnockout
function enemyInfoOnCharacterKnockout() {

	// Track the death
	{
		var enemy_id = m_enemyinfo_id;
	
		// Mark enemy as dead.
		with (kQuestManager)
		{
			enemy_live_map[?enemy_id] = kEnemyInfoLiveState_Dead;
		}
	}

	// Track the death counts
	if (m_saveTracked)
	{
		var enemy_id = m_enemyinfo_id;
		var enemy_info = undefined;
		with (kQuestManager)
		{
			enemy_info = ds_map_find_value(enemy_info_map, enemy_id);
		}
	
		if (is_undefined(enemy_info))
		{
			enemy_info = array_create(3);
		}
		enemy_info[0] += 1; // KO's
		//enemy_info[1] += 1; // Murdered/deaths
	
		// Save the new data
		with (kQuestManager)
		{
			enemy_info_map[?enemy_id] = enemy_info;
		}
	}


}
