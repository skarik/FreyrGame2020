/// @description Check Already Played & Init
m_initialized = false;

//questSetValue(kQidIntroSequence, 30); // DEBUG

if (questGetValue(kQidIntroSequence) != 30)
{
	/*if (questGetValue(kQidIntroSequence) > 30)
	{
		// Create music manager
		inew(o_mus00_DayDesert);
	}*/
	
	idelete(this);
	exit;
}

// Create a nathan if we need one
if (!iexists(o_chNathan))
{
	var pl = getPlayer();
	instance_create_depth(pl.x, pl.y + 32, pl.depth, o_chNathan);
}

// Load the cutscene
cutsceneLoad("00_initialLanding4.txt");

// Set not as running
m_running = false;

// Mark as ready
m_initialized = true;

// Set up music state to read
m_music_state = 0;