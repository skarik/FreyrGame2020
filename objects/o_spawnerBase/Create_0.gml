/// @description Spawn immediately
visible = false; // For idiots.
m_spawned_enemy = null;
if (!m_spawnOnlyOnTrigger)
{
	enemySpawnerCheckAndRespawn(this);
}
