/// @function enemyInfoOnDeath

if (m_saveTracked)
{
	var enemy_id = id;
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
	enemy_info[1] += 1; // Murdered/deaths
	
	// Save the new data
	with (kQuestManager)
	{
		enemy_info_map[?enemy_id] = enemy_info;
	}
}