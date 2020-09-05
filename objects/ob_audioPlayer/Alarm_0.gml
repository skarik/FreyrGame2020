/// @description begin playing sound

audio_falloff_set_model((falloff_model == kAudioFalloffModelExponential)
	? audio_falloff_exponent_distance_clamped
	: audio_falloff_linear_distance_clamped);
audio_emitter_falloff(m_emitter, falloff_start, falloff_end, falloff_factor);
audio_emitter_pitch(m_emitter, pitch);

// update gain
if (channel == kSoundChannelWorld || channel == kSoundChannelKey)
	audio_emitter_gain(m_emitter, gain * Settings.audio_sfx_volume * Settings.audio_total_volume);
else if (channel == kSoundChannelMusic)
	audio_emitter_gain(m_emitter, gain * Settings.audio_music_volume * Settings.audio_total_volume);
else if (channel == kSoundChannelSpeech)
	audio_emitter_gain(m_emitter, gain * Settings.audio_speech_volume * Settings.audio_total_volume);

audio_emitter_position(m_emitter, x, y, 0);

m_instance = audio_play_sound_on(m_emitter, m_sound, loop, priority);

//debugOut("Playing sound \"" + string(audio_get_name(m_sound)) + "\"");

if (!loop)
{
	m_despawnTimerEnabled = true;
	m_despawnTimer = audio_sound_length(m_sound) + 1.0;
}

