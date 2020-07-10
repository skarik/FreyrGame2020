enemyInfoClearLiveList();
gameRespawnEnemies(kRespawnEnemeiesMinor);
gameCampUntilMorning();

with (getPlayer())
{
	pstats.m_times_rested += 1;
}