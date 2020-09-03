/// @description Play audio

var audio = faudio_create_stream("music/world/crescent_theme_record.ogg");
m_sound = sound_play_at(x, y, audio);
m_sound.loop = true;
m_sound.falloff_start = 50;
m_sound.falloff_end = 200;
m_sound.falloff_factor = 1.0;
m_sound.falloff_model = kAudioFalloffModelLinear;
m_sound.gain = 0.7;
m_sound.channel = kSoundChannelMusic;