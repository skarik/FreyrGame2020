/// @function enemySpawnerCheckAndRespawn(spawner)
/// @param spawner {Object}
function enemySpawnerCheckAndRespawn(argument0) {

	with (argument0)
	{
		if (!iexists(m_spawned_enemy) || m_spawned_enemy.m_isKOed || m_spawned_enemy.m_isDead)
		{
			idelete(m_spawned_enemy);
		
			var enemyInfoLoadAction = enemyInfoOnPreSpawn();
			if (enemyInfoLoadAction == kEnemyInfoLoadAction_Spawn)
			{
				var character = instance_create_depth(x, y, depth, m_characterToSpawn);
				if (iexists(character)) // Can fail if it's a follower being spawned
				{
					character.m_enemyinfo_id = id;
					character.m_saveTracked = m_saveTracked; // Override save tracked state
		
					m_spawned_enemy = character;
			
					event_user(1); // On character respawned
				}
			}
			else if (enemyInfoLoadAction == kEnemyInfoLoadAction_DontSpawn)
			{
				// Nothing here, really.
			}
		}
	}


}
