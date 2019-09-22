/// @description Create music after initial cts

if (questGetValue(kQidIntroSequence) > 30
	|| (!exists(o_cts00_0_InitialLanding) && !exists(o_cts00_3_InitialWalkDown))
	)
{
	// Create music manager
	if (timeofdayIsDaytime())
	{
		new(o_mus00_DayDesert);
	}
	else
	{
		new(o_mus00_NightDesert);
	}
}

delete(this);