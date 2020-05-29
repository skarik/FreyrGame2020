/// @function sound_play_at(x, y, audio)
/// @param x
/// @param y
/// @param audio
/// @notes loop, priority, falloff_start, falloff_end, falloff_factor, gain, pitch, parent
var at_x = argument0;
var at_y = argument1;
var sound_to_play = argument2;

//if (sound_to_play != null && audio_exists(sound_to_play))
if (sound_to_play != null)
{
	var player = inew(ob_audioPlayer);
		player.x = at_x;
		player.y = at_y;
		player.m_sound = sound_to_play;
		player.m_streamed = audio_get_type(sound_to_play) == 1;
		
	return player;
}

return null;