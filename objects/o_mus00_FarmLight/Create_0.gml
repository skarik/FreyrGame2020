/// @description Special music player...

all_update_cooldown_cdtimer = 2.0;
all_update_begin_death = false;
all_update_death_blend = 0.0;
all_update_initial_room = room;

music_play_request_short = choose("audio/music/farm_piano_short_1.ogg",
								  "audio/music/farm_piano_short_7.ogg");
music_play_request_medium = null;
music_play_cdtimer = 0.0;

music_current = null;

persistent = true;