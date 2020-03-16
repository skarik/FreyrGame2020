/// @description Free the audio state

// Loop through all the audio, destroying all audio
for (var i = 0; i < array_length_1d(m_definition.sounds); ++i)
{
	var soundinfo = m_definition.sounds[i];
	
	if (exists(m_audioSound[i]))
	{
		delete(m_audioSound[i]); // this SHOULD handle freeing streams as well
		m_audioSound[i] = null;
	}
	
	if (soundinfo.type == kSoundscapeSoundTypeRandom)
	{
		if (ds_exists(m_audioIndexDeck[i], ds_type_list))
		{
			ds_list_destroy(m_audioIndexDeck[i]);
			m_audioIndexDeck[i] = null;
		}
	}
}