/// @description Cleanup

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
else
{
	// todo: make audio manager.
	audio_emitter_free(m_emitter);
}