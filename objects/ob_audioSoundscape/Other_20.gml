/// @description Update audio state

/// @description Spin up the audio state

// Loop through all the audio, setting up states
for (var i = 0; i < array_length_1d(m_definition.sounds); ++i)
{
	var soundinfo = m_definition.sounds[i];
	if (soundinfo.type == kSoundscapeSoundTypeLooping)
	{
		m_audioSound[i].gain = soundinfo.volume_min * m_strength;
		sound_update_params(m_audioSound[i]);
	}
	else if (soundinfo.type == kSoundscapeSoundTypeRandom)
	{
		m_audioCooldown[i] -= Time.deltaTime;
		m_audioSound[i] = null;
	}
}