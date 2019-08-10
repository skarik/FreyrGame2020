/// @description set music

// todo: actually play the music


var pl = getPlayer();

//with (ob_musicPlayer)
//{
	//if (m_fadeOut) continue;
			
if (room == rm_oasis_town)
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
}
//}

event_inherited();