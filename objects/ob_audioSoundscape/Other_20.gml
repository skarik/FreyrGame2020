/// @description Update audio state

var l_ambientDuckMultiplier = saturate(1.0 - windAudioGlobalGetSoundscapeDucking()) * 0.9 + 0.1;
var l_ambientDuckMultiplierRandom = lerp(l_ambientDuckMultiplier, 1.0, 0.5);

// Loop through all the audio, setting up states
for (var i = 0; i < array_length_1d(m_definition.sounds); ++i)
{
	var soundinfo = m_definition.sounds[i];
	if (soundinfo.type == kSoundscapeSoundTypeLooping)
	{
		m_audioSound[i].gain = soundinfo.volume_min * m_strength * l_ambientDuckMultiplier;
		sound_update_params(m_audioSound[i]);
	}
	else if (soundinfo.type == kSoundscapeSoundTypeRandom)
	{
		m_audioCooldown[i] -= Time.deltaTime;
		//m_audioSound[i] = null;
		
		if (m_audioCooldown[i] <= 0.0)
		{
			// Build deck if needed 
			if (ds_list_empty(m_audioIndexDeck[i]))
			{
				for (var k = 0; k < array_length_1d(soundinfo.wavelist); ++k)
					ds_list_add(m_audioIndexDeck[i], k);
			}
			
			// Pull a sound from the deck
			var cardIndex = floor(random(ds_list_size(m_audioIndexDeck[i])));
			var audioIndex = ds_list_find_value(m_audioIndexDeck[i], cardIndex);
			ds_list_delete(m_audioIndexDeck[i], cardIndex);

			// Load the sound			
			var audioHandle = audio_get_index(soundinfo.wavelist[audioIndex]);
			if (audioHandle == null)
			{
				audioHandle = faudio_create_stream(soundinfo.wavelist[audioIndex]);
			}
			
			// Set new cooldown
			m_audioCooldown[i] = faudio_sound_get_length(audioHandle) + random_range(soundinfo.time_min, soundinfo.time_max);
			
			// Select a position
			var soundpos = [0, 0];
			if (soundinfo.position == kSoundscapeSoundPositionRandom)
			{
				var random_dir = random(360);
				var random_dist = random_range(200, 500);
				soundpos = [GameCamera.x + lengthdir_x(random_dist, random_dir), GameCamera.y + lengthdir_y(random_dist, random_dir)];
			}
			else if (soundinfo.position == kSoundscapeSoundPositionRandomNear)
			{
				var random_dir = random(360);
				var random_dist = random_range(100, 250);
				soundpos = [GameCamera.x + lengthdir_x(random_dist, random_dir), GameCamera.y + lengthdir_y(random_dist, random_dir)];
			}
			else if (soundinfo.position == kSoundscapeSoundPositionRandomFar)
			{
				var random_dir = random(360);
				var random_dist = random_range(450, 800);
				soundpos = [GameCamera.x + lengthdir_x(random_dist, random_dir), GameCamera.y + lengthdir_y(random_dist, random_dir)];
			}
			else if (soundinfo.position == 0 && exists(m_position0))
				soundpos = [m_position0.x, m_position0.y];
			else if (soundinfo.position == 1 && exists(m_position1))
				soundpos = [m_position1.x, m_position1.y];
			else if (soundinfo.position == 2 && exists(m_position2))
				soundpos = [m_position2.x, m_position2.y];
			else if (soundinfo.position == 3 && exists(m_position3))
				soundpos = [m_position3.x, m_position3.y];
			
			// Play the sound
			m_audioSound[i] = sound_play_at(soundpos[0], soundpos[1], audioHandle);
			m_audioSound[i].pitch = random_range(soundinfo.pitch_min, soundinfo.pitch_max);
			m_audioSound[i].gain = random_range(soundinfo.volume_min, soundinfo.volume_max) * l_ambientDuckMultiplierRandom;
			m_audioSound[i].loop = false;
		}
	}
}