/// @description gaudio_play_sound(soundid, priority, loops)
/// @param soundid
/// @param priority
/// @param loops

var sound = audio_play_sound(argument0, argument1, argument2);
audio_sound_gain(sound, Settings.audio_sfx_volume, 0.0);
return sound;