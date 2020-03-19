/// @function faudio_play2_file(filename, streamed, looped)
/// @description Plays file with a heavily managed audio object
/// @param filename
/// @param streamed
/// @param looped

var filename = argument0;
var streamed = argument1;
var looped = argument2;

if (!file_exists(filename))
{
	show_error("Could not find the audio '" + filename + "' for open.", true);
    return null;
}

var audio_player = new2(ob_audioPlayer2);

if (streamed)
{
	audio_player.m_streamed = streamed;
	audio_player.m_stream = audio_create_stream(filename);
	audio_player.m_audio = 	audio_play_sound(audio_player.m_stream, 100, looped);
	audio_sound_gain(audio_player.m_audio, Settings.audio_sfx_volume, 0.0);
}

return audio_player;