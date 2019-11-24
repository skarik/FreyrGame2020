/// @description Update volume

if (!exists(m_music))
{
	event_user(0);
}

// initialize track volume array
var track_count = array_length_1d(m_tracks);
if (array_length_1d(m_trackVolume) != track_count)
{
	m_trackVolume = array_create(track_count);
}

// update volume:
if (exists(m_music))
{
	for (var i = 0; i < track_count; ++i)
	{
		m_music.m_trackVolume[i] = m_trackVolume[i];
	}
}