/// @function enemyInfoOnPreSpawn()
/// @return {kEnemyInfoLoadAction}
/// @desc Called by the spawner to check the respawn state of the NPC

#macro kEnemyInfoLoadAction_Spawn 0
#macro kEnemyInfoLoadAction_DontSpawn 1

if (!m_saveTracked)
{
	return kEnemyInfoLoadAction_Spawn;
}
else
{
	// First check if it's been killed or not
	var live_id = id;
	var live_info = undefined;
	with (kQuestManager)
	{
		live_info = ds_map_find_value(enemy_live_map, live_id);
	}
	// If not in the live map, treat as OK to respawn (mark alive)
	if (is_undefined(live_info))
	{
		live_info = kEnemyInfoLiveState_Alive;
	}
	
	if (live_info == kEnemyInfoLiveState_Dead)
	{
		return kEnemyInfoLoadAction_DontSpawn; // Don't spawn if already dead
	}
	else // If live state is missing/clear, then we check for the respawn count.
	{
		if (m_respawnCount == -1)
		{	// Infinite respawn count.
			return kEnemyInfoLoadAction_Spawn;
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
				return kEnemyInfoLoadAction_Spawn;
			}
			else
			{
				// With enemy info, count number of deaths/ko's
				//if (max(enemy_info[0], enemy_info[1]) > m_respawnCount)
				// only deaths count for now
				if (enemy_info[1] > m_respawnCount)
				{
					return kEnemyInfoLoadAction_DontSpawn; // No need to spawn if here.
				}
			}
		}
	}
	// End save-tracking
}

// Fall-thru case
return kEnemyInfoLoadAction_Spawn;