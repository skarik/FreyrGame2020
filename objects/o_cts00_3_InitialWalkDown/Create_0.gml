/// @description Check Already Played & Init
m_initialized = false;

if (questGetValue(kQidIntroSequence) != 30)
{
	if (questGetValue(kQidIntroSequence) > 30)
	{
		// Create music manager
		new(o_mus00_Oasis);
	}
	
	delete(this);
	exit;
}

// Mark as ready
m_initialized = true;