function gameCampCheckpointShortRest() {
	enemyInfoClearLiveList();
	gameRespawnEnemies(kRespawnEnemeiesMinor);
	gameCampWait(0.01);
	if (iexists(o_ctsGameMakeCamp))
	{
		o_ctsGameMakeCamp.m_runtime = 1.0;
	}

	with (getPlayer())
	{
		pstats.m_times_rested += 1;
	}


}
