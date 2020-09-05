/// @description set music

// todo: actually play the music

var pl = getPlayer();

m_fadeSpeed = 2.0;

// Zero out all volumes first:
for (var i = 0; i < array_length_1d(m_trackVolume); ++i)
{
	m_trackVolume[i] = 0.0;
}

if (room == rm_oasis_farm)
{
	// Nothing.
}
else if (room == rm_oasis_town)
{
	if (iexists(o_doodadTentChonkHider) && o_doodadTentChonkHider.image_alpha < 0.1)
	{
		// a hack that needs to move to a cutscene
		pl.m_currentAreaTimer = 0.0;
		
		if (questGetValue(kQidIntroSequence) > 20)
		{
			m_trackVolume[1] = 1.0;
		}
	}
	else if (questGetValue(kQidIntroSequence) < 20)
	{	// birdshit on a beam (hack) (unused)
		m_trackVolume[3] = 1.0;
	}
	else
	{	// step outside
		m_trackVolume[0] = 1.0;
	}
}
else if (room == rm_oasis_north)
{
	m_trackVolume[5] = 1.0;
}
else if (room == rm_oasis_overlook)
{
	if (iexists(pl))
	{
		if (pl.y < 360)
		{
			m_trackVolume[2] = 1.0;
			
			m_fadeSpeed = 0.5;
		}
		else if (pl.y < 660)
		{
			m_trackVolume[0] = 1.0;
			
			m_fadeSpeed = 0.5;
		} 
		else if (pl.y < 950)
		{
			m_trackVolume[0] = 1.0;
			
			m_fadeSpeed = 0.5;
		} 
		else
		{
			m_trackVolume[4] = 1.0;
			
			m_fadeSpeed = 0.5;
		}
	}
}

event_inherited();