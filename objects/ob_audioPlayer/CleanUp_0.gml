/// @description Cleanup

audio_stop_sound(m_instance);
audio_emitter_free(m_emitter);

if (m_streamed)
{
	if (audio_is_playing(m_audio))
	{
		audio_stop_sound(m_audio);
	}
	if (m_stream != null)
	{
		audio_destroy_stream(m_stream);
	}
}