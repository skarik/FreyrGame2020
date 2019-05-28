loop = false;
priority = 5;

falloff_start = 100;
falloff_end = 1000;
falloff_factor = 1;

gain = 1.0;
pitch = 1.0;

// System:
m_sound = null;
m_streamed = false;
m_stream = null;
m_emitter = audio_emitter_create();
m_instance = null;

alarm[0] = 1;  // Alarm to play sound
alarm[1] = 20; // Alarm to check for destruction

