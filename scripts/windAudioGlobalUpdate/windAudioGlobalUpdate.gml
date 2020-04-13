var current_wind = weatherGetWind();
var current_location_type = worldGameLocationType();

// steps of wind levels:
/// weak: 0 to 200
/// medium: 200 to 400
/// high: 400+

var current_wind_magnitude = sqrt(sqr(current_wind[0]) + sqr(current_wind[1]));

//
// Calculate saved magnitude, with delay (like a volume monitor, has a delay before dropping)

if (current_wind_magnitude > m_windMagnitude)
{
	m_windMagnitude = current_wind_magnitude;
	m_windMagnitudeDropTimer = 2.0;
}
else
{
	m_windMagnitudeDropTimer -= 1.0 * Time.deltaTime;
	if (m_windMagnitudeDropTimer < 0.0)
	{
		var delta = current_wind_magnitude - m_windMagnitude;
		m_windMagnitude += sign(delta) * min(abs(delta), 100.0 * Time.deltaTime);
	}
}

//
// Select audio to play

var next_requested_id = null;

if (current_location_type & kWorldLocationType_Bitmask_Cave)
{
	next_requested_id = snd_windCave;
	m_windTargetVolume = saturate(sqrt(m_windMagnitude) / 30 - 0.25);
}
else
{
	if (m_windMagnitude < 200)
	{
		// select smol
		next_requested_id = snd_windWeakLowlands;
		m_windTargetVolume = saturate(sqrt(m_windMagnitude) / 30 - 0.25);
	}
	else if (m_windMagnitude < 400)
	{
		// select med
		next_requested_id = snd_windMedium;
		m_windTargetVolume = saturate(m_windMagnitude / 360 - 0.125);
	}
	else
	{
		// big
		next_requested_id = snd_windStrong;
		m_windTargetVolume = saturate(m_windMagnitude / 580  - 0.125);
	}
}

debugOut("wind volume: " + string(m_windTargetVolume));

//
// Swap sound states if we got a new one we want to fade in

if (next_requested_id != m_windSoundMainId)
{
	// Start the new audio only when we can swap a track to fadeout state:
	if (m_windSoundMain == null || (m_windSoundFadeout == null || m_windSoundFadeout == next_requested_id))
	{
		// Switch old audio to the fadeout track
		if (m_windSoundMain != null)
		{
			// If nothing in the fadeout channel, just shunt current main audio into it
			if (m_windSoundFadeout == null)
			{
				m_windSoundFadeout = m_windSoundMain;
				m_windSoundFadeoutId = m_windSoundMainId;
				m_windSoundFadeoutGain = m_windSoundMainGain;
			}
			// If it's right on the edge, may want to just swap tracks
			else
			{
				var temp = m_windSoundFadeout;
				var tempId = m_windSoundFadeoutId;
				var tempGain = m_windSoundFadeoutGain;
				
				m_windSoundFadeout = m_windSoundMain;
				m_windSoundFadeoutId = m_windSoundMainId;
				m_windSoundFadeoutGain = m_windSoundMainGain;
				
				m_windSoundMain = temp;
				m_windSoundMainId = tempId;
				m_windSoundFadeoutGain = tempGain;
			}
		}
		
		m_windSoundMain = faudio_play_sound(next_requested_id, 50, true);
		m_windSoundMainId = next_requested_id;
		m_windSoundMainGain = 0.0;
	}
}

//
// Fade in the main sound

if (m_windSoundMain != null)
{
	var gain_delta = m_windTargetVolume - m_windSoundMainGain;
	var gain_delta_timed = sign(gain_delta) * min(abs(gain_delta), m_windVolumeTransitionSpeed * Time.deltaTime);
	
	m_windSoundMainGain += gain_delta_timed;
	faudio_sound_set_gain(m_windSoundMain, m_windSoundMainGain);
}

//
// Fade out the fadeout sound

if (m_windSoundFadeout != null)
{
	m_windSoundFadeoutGain -= Time.deltaTime * m_windVolumeTransitionSpeed;
	if (m_windSoundFadeoutGain > 0.0)
	{
		faudio_sound_set_gain(m_windSoundFadeout, m_windSoundFadeoutGain);
	}
	else
	{
		faudio_sound_stop(m_windSoundFadeout);
		m_windSoundFadeout = null;
		m_windSoundFadeoutId = null;
	}
}