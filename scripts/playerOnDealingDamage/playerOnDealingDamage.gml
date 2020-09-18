function playerOnDealingDamage()
{
	// Perform stamina usage
	if (m_isPlayer)
		m_willpush -= 1.0;

	if (Settings.gameplay_mlg_farm_mode)
	{
		if (m_isPlayer)
		{
			// Do some sick MLG effects
			var sound = sound_play_at(0, 0, "audio/sfx/mlg_hitmarker.wav");
			sound.channel = kSoundChannelUi;
			sound.spatial = kAudioSpatial2D;
			var hitmarker = inew(o_ptcMlgHitMarker);
			hitmarker.x = x + random_range(-8, +8);
			hitmarker.y = y + random_range(-8, +8);
			effectScreenShake(3.0, 0.2, false);
		}
	}
}
