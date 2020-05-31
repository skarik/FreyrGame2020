/// @description Create music after initial cts

if (questGetValue(kQidIntroSequence) > 30
	|| (!iexists(o_cts00_0_InitialLanding) && !iexists(o_cts00_3_InitialWalkDown))
	)
{
	// Create music manager
	/*if (timeofdayIsDaytime())
	{
		inew(o_mus00_DayDesert);
	}
	else
	{
		inew(o_mus00_NightDesert);
	}*/
	if (!iexists(o_mus00_Oasis))
	{
		//inew(o_mus00_Oasis);
		//questSetValue(kQidIntroSequence, 40); // HACK
	}
	
	if (!iexists(o_mus00_FarmLight))
		inew(o_mus00_FarmLight);
}
else if (questGetValue(kQidIntroSequence) > 10)
{
	if (!iexists(o_mus00_Oasis))
	{
		//inew(o_mus00_Oasis);
	}
}

fmusic_fade_all();

idelete(this);