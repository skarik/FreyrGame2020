/// @description Play audio

m_sound = sound_play_at(x, y, "music/world/crescent_theme_record.ogg");
m_sound.loop = true;
m_sound.falloff_start = 100;
m_sound.falloff_end = 320;
m_sound.falloff_factor = 1.0;
m_sound.falloff_model = kAudioFalloffModelLinear;
m_sound.gain = 0.01;
m_sound.channel = kSoundChannelMusic;