/// @description faudio_play_file(music_instance)
/// @param music_instance

var music_player = argument0;

for (var i = 0; i < music_player.m_trackCount; ++i)
{
	audio_sound_set_track_position(music_player.m_track[i], 0.0);
}
/*
for (var i = 0; i < music_player.m_trackCount; ++i)
{
	audio_resume_sound(music_player.m_track[i]);
}
*/
return music_player;