/// @description faudio_play_sound(soundid, priority, loops, channel)
/// @param soundid
/// @param priority
/// @param loops
/// @param channel
function faudio_play_sound(argument0, argument1, argument2, argument3) {

	var soundid = argument0;
	if (is_string(soundid))
	{
		soundid = faudio_create_stream(soundid);
	}
	var channel = argument3;

	var sound = audio_play_sound(soundid, argument1, argument2);
	if (channel == kSoundChannelKey || channel == kSoundChannelWorld)
		audio_sound_gain(sound, Settings.audio_sfx_volume * Settings.audio_total_volume, 0.0);
	else if (channel == kSoundChannelMusic)
		audio_sound_gain(sound, Settings.audio_music_volume * Settings.audio_total_volume, 0.0);
	else if (channel == kSoundChannelSpeech)
		audio_sound_gain(sound, Settings.audio_speech_volume * Settings.audio_total_volume, 0.0);
	return sound;


}
