/// @description Check if sounds playing

if (m_streamed)
{
	if (!audio_is_playing(m_audio))
	{
		delete(this);
	}
}