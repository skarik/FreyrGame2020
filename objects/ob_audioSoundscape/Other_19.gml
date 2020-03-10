/// @description Free the audio state

// Loop through all the audio, destroying all audio
for (var i = 0; i < array_length_1d(m_definition.sounds); ++i)
{
	if (exists(m_audioSound[i]))
	{
		delete(m_audioSound[i]); // this SHOULD handle freeing streams as well
		m_audioSound[i] = null;
	}
}