/// @description Despawn/Spawn behavior

if (m_activeDespawnManagement)
{
	var kDespawnEdgeDistance = 400;
	var kSpawnEdgeDistance = 300;
	
	// Work on despawning
	if (iexists(m_spawned_enemy))
	{
		if (!point_on_camera_wide(m_spawned_enemy.x, m_spawned_enemy.y, kDespawnEdgeDistance, kDespawnEdgeDistance)
			&& !point_on_camera_wide(x, y, kDespawnEdgeDistance, kDespawnEdgeDistance))
		{
			idelete(m_spawned_enemy);
			m_spawned_enemy = null;
		}
	}
	// Work on spawning
	else if (!m_spawnOnlyOnTrigger)
	{
		if (point_on_camera_wide(x, y, kSpawnEdgeDistance, kSpawnEdgeDistance))
		{
			enemySpawnerCheckAndRespawn(this);
		}
	}
}