var sound = argument0;
with (sound)
{
	audio_falloff_set_model(audio_falloff_exponent_distance);
	audio_emitter_falloff(m_emitter, falloff_start, falloff_end, falloff_factor);
	audio_emitter_pitch(m_emitter, pitch);
	audio_emitter_gain(m_emitter, gain * Settings.audio_sfx_volume);
	audio_emitter_position(m_emitter, x, y, 0);
}