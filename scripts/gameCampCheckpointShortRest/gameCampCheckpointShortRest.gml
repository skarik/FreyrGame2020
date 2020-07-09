enemyInfoClearLiveList();
gameRespawnEnemies(kRespawnEnemeiesMinor);
gameCampWait(0.01);

with (getPlayer())
{
	pstats.m_times_rested += 1;
}