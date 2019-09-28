/// @description set music

// todo: actually play the music


var pl = getPlayer();
	
/*if (room == rm_oasis_town)
{
	if (exists(o_doodadTentChonkHider) && o_doodadTentChonkHider.image_alpha < 0.1)
	{
		m_trackVolume[0] = 0.0;
		m_trackVolume[1] = 1.0;
		m_trackVolume[2] = 0.0;
		m_trackVolume[3] = 0.0;
		m_trackVolume[4] = 0.0;
		m_trackVolume[5] = 0.0;
		
		// a hack that needs to move to a cutscene
		pl.m_currentAreaTimer = 0.0;
	}
	else
	{	// step outside
		m_trackVolume[0] = 0.0;
		m_trackVolume[1] = 0.0;
		m_trackVolume[2] = 1.0;
		m_trackVolume[3] = 0.0;
		m_trackVolume[4] = 0.0;
		m_trackVolume[5] = 0.0;
	}
}
else if (room == rm_oasis_north)
{
	m_trackVolume[0] = 0.0;
	m_trackVolume[1] = 0.0;
	m_trackVolume[2] = 0.0;
	m_trackVolume[3] = 0.0;
	m_trackVolume[4] = 1.0;
	m_trackVolume[5] = 0.0;
}
else if (room == rm_oasis_north_cave)
{
	m_trackVolume[0] = 0.0;
	m_trackVolume[1] = 0.0;
	m_trackVolume[2] = 0.0;
	m_trackVolume[3] = 0.0;
	m_trackVolume[4] = 0.0;
	m_trackVolume[5] = 1.0;
}*/

// Zero out all volumes first:
for (var i = 0; i < 11; ++i) {
	m_trackVolume[i] = 0.0;
}

if (room == rm_oasis_farm)
{
	if (questGetValue(kQidIntroSequence) >= 30 && exists(o_cts00_3_InitialWalkDown))
	{
		m_trackVolume[0] = 1.0;
		m_trackVolume[1] = (o_cts00_3_InitialWalkDown.m_music_state > 1) ? 1.0 : 0.0;
		m_trackVolume[5] = (o_cts00_3_InitialWalkDown.m_music_state > 0) ? 1.0 : 0.0;
		m_trackVolume[7] = 1.0;
		m_trackVolume[8] = (o_cts00_3_InitialWalkDown.m_music_state > 2) ? 0.0 : 1.0;
	}
	else if (questGetValue(kQidIntroSequence) >= 40)
	{
		var kGloom = 4.0;
		var kSunrise = 6.0;
		var kNoon = 12.0;
		var kSunset = 18.0;
		var kDarkness = 20.0;
		var timeofday = timeofdayGetHour();
		
		m_trackVolume[0] = (timeofday > 5.25 && timeofday < 20.0) ? saturate((19.5 - timeofday)) : 0.0;
		m_trackVolume[1] = (timeofday > 6.0 && timeofday < 18.0) ? 1.0 : 0.0;
		m_trackVolume[2] = (timeofday > 18.0 && timeofday < 20.0) ? saturate((20.0 - timeofday)) : 0.0;
		m_trackVolume[5] = (timeofday > 5.5 && timeofday < 16.0) ? 1.0 : 0.0;
		m_trackVolume[7] = (timeofday > 6.0 && timeofday < 16.0) ? 1.0 : 0.0;
		m_trackVolume[6] = (timeofday > 5.0 && timeofday < 6.0) ? 1.0 : 0.0;
		m_trackVolume[8] = (timeofday > 5.0 && timeofday < 6.0) ? 1.0 : 0.0;
	}
	/*else
	{
		m_trackVolume[0] = 1.0;
		m_trackVolume[7] = 1.0;
		m_trackVolume[8] = 1.0;
	}*/
}
else if (room == rm_oasis_town)
{
	if (exists(o_doodadTentChonkHider) && o_doodadTentChonkHider.image_alpha < 0.1)
	{
		// a hack that needs to move to a cutscene
		pl.m_currentAreaTimer = 0.0;
	}
	else if (questGetValue(kQidIntroSequence) < 20)
	{	// birdshit on a beam (hack)
		m_trackVolume[0] = 1.0;
		m_trackVolume[1] = 1.0;
	}
	else
	{	// step outside
		m_trackVolume[0] = 1.0;
		m_trackVolume[1] = 1.0;
		m_trackVolume[4] = 1.0;
		m_trackVolume[7] = 1.0;
		m_trackVolume[9] = 1.0;
	}
}
else if (room == rm_oasis_north)
{
	m_trackVolume[0] = 1.0;
	m_trackVolume[2] = 1.0;
	m_trackVolume[4] = 1.0;
	m_trackVolume[6] = 1.0;
	m_trackVolume[7] = 1.0;
	m_trackVolume[8] = 1.0;
}
else if (room == rm_oasis_overlook)
{
	var pl = getPlayer();
	if (exists(pl))
	{
		if (pl.y < 950)
		{
			m_trackVolume[2] = 1.0;
			m_trackVolume[3] = 1.0;
			m_trackVolume[5] = 1.0;
			m_trackVolume[10] = (pl.y < 360) ? 1.0 : 0.0;
		}
		else
		{
			m_trackVolume[0] = 1.0;
			m_trackVolume[1] = 1.0;
			m_trackVolume[4] = 1.0;
			m_trackVolume[7] = 1.0;
			m_trackVolume[9] = 1.0;
		}
	}
}

// "Normalize" volumes
var total_volume = 0.0;
for (var i = 0; i < 11; ++i)
{
	total_volume += m_trackVolume[i];
}
var normalize_amount = lerp(0.5, 1.0, saturate(1.0 / (total_volume + 0.01)) );
for (var i = 0; i < 11; ++i)
{
	m_trackVolume[i] *= normalize_amount;
}

event_inherited();