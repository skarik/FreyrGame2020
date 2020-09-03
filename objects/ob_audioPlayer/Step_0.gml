/// @description move audio to parent position

if (iexists(parent))
{
	x = parent.x;
	y = parent.y;
	audio_emitter_position(m_emitter, x, y, 0);
}

// update gain
if (channel == kSoundChannelWorld || channel == kSoundChannelKey)
	audio_emitter_gain(m_emitter, gain * Settings.audio_sfx_volume * Settings.audio_total_volume);
else if (channel == kSoundChannelMusic)
	audio_emitter_gain(m_emitter, gain * Settings.audio_music_volume * Settings.audio_total_volume);
else if (channel == kSoundChannelSpeech)
	audio_emitter_gain(m_emitter, gain * Settings.audio_speech_volume * Settings.audio_total_volume);