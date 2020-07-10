enemyInfoClearLiveList();
gameRespawnEnemies(kRespawnEnemeiesMinor);
gameCampWait(0.01);
if (iexists(o_ctsGameMakeCamp))
{
	o_ctsGameMakeCamp.m_runtime = 0.2;
}

with (getPlayer())
{
	pstats.m_times_rested += 1;
}