/// @description Check if the player has rested, and if they have, increment the flag

if (questGetValue(kQidIntroSequence) == 40)
{
	var pl = getPlayer();
	if (m_times_rested == null)
	{
		m_times_rested = pl.pstats.m_times_rested;
	}
	
	// check the rest stats
	if (pl.pstats.m_times_rested > m_times_rested)
	{
		questSetValue(kQidIntroSequence, 50);
		idelete(this); // no longer needed here
	}
}