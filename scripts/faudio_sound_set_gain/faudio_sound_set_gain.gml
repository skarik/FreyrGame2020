/// @description faudio_sound_set_gain(soundid, gain)
/// @param soundid
/// @param gain
function faudio_sound_set_gain(argument0, argument1) {

	audio_sound_gain(argument0, Settings.audio_sfx_volume * Settings.audio_total_volume * argument1, 0.0);


}
