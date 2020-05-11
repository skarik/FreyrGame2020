/// @function enemyInfoOnCreate()
/// @return {kEnemyInfoLoadAction}

#macro kEnemyInfoLoadAction_None 0
#macro kEnemyInfoLoadAction_Exit 1

if (!m_saveTracked)
{
	return kEnemyInfoLoadAction_None;
}
else
{
	if (m_respawnCount == -1)
	{	// Infinite respawn count.
		return kEnemyInfoLoadAction_None;
	}
	else
	{
		// Check for enemy info
		var enemy_id = id;
		var enemy_info = undefined;
		with (kQuestManager)
		{
			enemy_info = ds_map_find_value(enemy_info_map, enemy_id);
		}
		
		if (is_undefined(enemy_info))
		{	// Not tracked - no need to check the death count at the moment.
			return kEnemyInfoLoadAction_None;
		}
		else
		{
			// With enemy info, count number of deaths/ko's
			if (max(enemy_info[0], enemy_info[1]) > m_respawnCount)
			{
				delete(this);
				return kEnemyInfoLoadAction_Exit; // Force the init to be skipped.
			}
		}
	}
	
	// End save-tracking
}