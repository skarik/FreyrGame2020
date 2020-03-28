/// @description play some music

var prev_timer = music_play_countdown_timer;
music_play_countdown_timer -= Time.deltaTime;

if (music_play_countdown_timer <= 0.0 && prev_timer > 0)
{
	// play music 
	faudio_play2_file(choose("audio/music/farm_piano_short_1.ogg",
							 "audio/music/farm_piano_short_7.ogg"),
					  true,
					  false);
}