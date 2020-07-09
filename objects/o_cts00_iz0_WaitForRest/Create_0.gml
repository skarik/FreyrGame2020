/// @description Check Already Played & Init
m_initialized = false;

if (questGetValue(kQidIntroSequence) > 40)
{
	idelete(this);
	exit;
}

// Mark as ready
m_initialized = true;

// Save times rested
m_times_rested = null;