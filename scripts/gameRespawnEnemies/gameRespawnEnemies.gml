/// @function gameRespawnEnemies(which)
/// @param which {kRespawnEnemeies}

#macro kRespawnEnemeiesMinor 0x01
#macro kRespawnEnemeiesMajor 0x02
#macro kRespawnEnemeiesAll	 (0x01|0x02)

var respawn_which = argument0;

// Spawn the enemies
with (ob_spawner)
{
	if (!m_spawnOnlyOnTrigger)
	{
		if (  (!m_characterIsMajor && (respawn_which & kRespawnEnemeiesMinor))
			|| (m_characterIsMajor && (respawn_which & kRespawnEnemeiesMajor)))
		{
			enemySpawnerCheckAndRespawn(id);
		}
	}
}