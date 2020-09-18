function mlgmodeGlobalUpdate() {
	if (Settings.gameplay_mlg_farm_mode)
	{
		var player = getPlayer();
	
		// Do some epic effects when the player does sick things.
		var harvest_size = ds_map_size(player.pstats.m_harvestedCrops);
		var crop = ds_map_find_first(player.pstats.m_harvestedCrops);
		for (var i = 0; i < harvest_size; ++i)
		{
			crop = ds_map_find_next(player.pstats.m_harvestedCrops, crop);
			var curr_value = ds_map_find_value(player.pstats.m_harvestedCrops, crop);
			var prev_value = ds_map_find_value(mlg_harvestCropsPrevious, crop);
		
			// We have a value?
			if (!is_undefined(prev_value) && prev_value < curr_value)
			{
				// Play hit sound, always
				if (crop == kCropId_AllCrops)
				{
					var sound = sound_play_at(0, 0, "audio/sfx/mlg_hitmarker.wav");
					sound.channel = kSoundChannelUi;
					sound.spatial = kAudioSpatial2D;
					var hitmarker = inew(o_ptcMlgHitMarker);
					hitmarker.x = player.x + random_range(-8, +8);
					hitmarker.y = player.y + random_range(-8, +8);
					effectScreenShake(3.0, 0.2, false);
				}
				// Track penta's 
				if (curr_value % 5 == 0)
				{
					var sound = sound_play_at(0, 0, "audio/sfx/mlg_airhorn.wav");
					sound.channel = kSoundChannelUi;
					sound.spatial = kAudioSpatial2D;
					effectScreenShake(5.0, 1.0, true);
				}
				// Track triples
				else if (curr_value % 3 == 0)
				{
					var sound = sound_play_at(0, 0, "audio/sfx/mlg_triple.wav");
					sound.channel = kSoundChannelUi;
					sound.spatial = kAudioSpatial2D;
					effectScreenShake(3.0, 1.2, true);
				}
			}
		
			// Save new value
			mlg_harvestCropsPrevious[?crop] = curr_value;
		}
	}


}
