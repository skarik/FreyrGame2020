/// @function windAudioGlobalGetSoundscapeDucking()
/// @returns {Float} Amount 0 to 1 of to duck the soundscape volume.
function windAudioGlobalGetSoundscapeDucking() {

	var ducking = 0.0;
	with (Gameplay)
	{
		ducking = saturate((m_windMagnitude - 200) / 500);
	}
	return ducking;


}
