/// @description Spin up the audio state

// Loop through all the audio, setting up states
for (var i = 0; i < array_length_1d(m_definition.sounds); ++i)
{
	var soundinfo = m_definition.sounds[i];
	if (soundinfo.type == kSoundscapeSoundTypeLooping)
	{
		var audioHandle = audio_get_index(soundinfo.wavelist[0]);
		if (audioHandle == null)
		{
			audioHandle = gaudio_create_stream(soundinfo.wavelist[0]);
		}
		
		// Query playing position
		var soundpos = [0, 0];
		if (soundinfo.position == 0 && exists(m_position0))
			soundpos = [m_position0.x, m_position0.y];
		else if (soundinfo.position == 1 && exists(m_position1))
			soundpos = [m_position1.x, m_position1.y];
		else if (soundinfo.position == 2 && exists(m_position2))
			soundpos = [m_position2.x, m_position2.y];
		else if (soundinfo.position == 3 && exists(m_position3))
			soundpos = [m_position3.x, m_position3.y];
			
		// Begin playing sound
		m_audioSound[i] = sound_play_at(soundpos[0], soundpos[1], audioHandle);
		m_audioSound[i].pitch = soundinfo.pitch_min;
		m_audioSound[i].gain = soundinfo.volume_min;
		m_audioSound[i].loop = true;
	}
	else if (soundinfo.type == kSoundscapeSoundTypeRandom)
	{
		m_audioCooldown[i] = 1.0 + random_range(soundinfo.time_min, soundinfo.time_max);
		m_audioSound[i] = null;
	}
}