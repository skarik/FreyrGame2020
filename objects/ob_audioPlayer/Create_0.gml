#macro kAudioFalloffModelExponential 0
#macro kAudioFalloffModelLinear 1

loop = false;
priority = 5;

falloff_start = 100;
falloff_end = 1000;
falloff_factor = 1.0;
falloff_model = kAudioFalloffModelExponential;

gain = 1.0;
pitch = 1.0;

parent = null;

// System:
m_sound = null;
m_streamed = false;
m_stream = null;
m_emitter = audio_emitter_create();
m_instance = null;

alarm[0] = 1;  // Alarm to play sound
alarm[1] = 20; // Alarm to check for destruction

