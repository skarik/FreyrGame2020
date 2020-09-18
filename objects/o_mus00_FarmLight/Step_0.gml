/// @description play some music


var player = getPlayer();

// Update death case
if (all_update_initial_room != room)
{
	all_update_begin_death = true;
}

// Run main logic:
all_update_cooldown_cdtimer -= Time.unscaledDeltaTime;
if (!all_update_begin_death && all_update_cooldown_cdtimer <= 0.0)
{
	//
	// Audio trigger logic:
	
	if (timeofdayDidHourPass())
	{
		var l_hourOfDay = round(timeofdayGetHour());
		if (l_hourOfDay == 12)
		{	// cue daytime track
			//music_play_request_medium = "audio/music/farm_day_med_1.ogg";
		}
		else if (l_hourOfDay == 12 + 8)
		{	// cue nighttime track
			//music_play_request_medium = "audio/music/farm_night_med_1.ogg";
			music_play_request_medium = "music/farm/farm_night0.ogg";
		}
		else if (l_hourOfDay == 24 || l_hourOfDay == 0)
		{	// cue warning track
			if (player.m_will < player.m_willMax * 0.1)
			{
				//music_play_request_short = "audio/music/farm_piano_short_8.ogg";
			}
		}
		// select a random track (for now)
		else if (random(1.0) < 0.5 && !is_string(music_play_request_short))
		{
			music_play_request_short = choose("music/farm/farm_arrive_p1.ogg",
											  "music/farm/farm_arrive_p2.ogg",
											  "music/farm/farm_arrive_g1.ogg",
											  "music/farm/farm_arrive_g2.ogg");
		}
	}
	
	// 
	// Kill requests if currently being overridden
	
	if (is_string(music_play_request_short))
	{
		// If playing a medium or longer song, kill any short audio requests
		// so we don't have odd things stacked & playing up at the end.
		if (music_current != null && iexists(music_current) && faudioSourceIsPlaying(music_current.m_source))
		{
			if (faudioSourceGetSoundLength(music_current.m_source) > 45.0)
			{
				music_play_request_short = null;
			}
		}
	}
	
	// 
	// Begin playing music on triggers

	if (music_current == null || !iexists(music_current) || !faudioSourceIsPlaying(music_current.m_source))
	{
		music_play_cdtimer -= Time.deltaTime;
		if (music_play_cdtimer < 0)
		{
			// Do we have something to play?
			if (is_string(music_play_request_short))
			{
				music_current = sound_play_channel(music_play_request_short, kSoundChannelMusic);
				music_play_request_short = null;
				music_play_cdtimer = 1.0;
				debugOut("Playing short farm track");
			}
			else if (is_string(music_play_request_medium))
			{
				music_current = sound_play_channel(music_play_request_medium, kSoundChannelMusic);
				music_play_request_medium = null;
				music_play_cdtimer = 2.0;
				debugOut("Playing medium farm track");
			}
		}
	}
}

// Update volumes:
if (music_current != null && iexists(music_current))
{
	if (!all_update_begin_death)
	{
		// Set normal volume
		/*if (audio_is_playing(music_current.m_audio))
		{
			audio_sound_gain(music_current.m_audio, 1.4 * Settings.audio_music_volume * Settings.audio_total_volume, 0.0);
		}*/
		music_current.gain = 1.4;
	}
	else
	{
		// If death marked, fade out
		/*if (audio_is_playing(music_current.m_audio))
		{
			audio_sound_gain(music_current.m_audio, 1.4 * Settings.audio_music_volume * Settings.audio_total_volume * saturate(1.0 - all_update_death_blend), 0.0);
		}*/
		music_current.gain = 1.4 * saturate(1.0 - all_update_death_blend);
	}
}

// Update death trigger
if (all_update_begin_death)
{
	// Perform blend & delete after the full blend done
	all_update_death_blend += Time.unscaledDeltaTime;
	if (all_update_death_blend > 1.0)
	{
		idelete(this);
	}
}