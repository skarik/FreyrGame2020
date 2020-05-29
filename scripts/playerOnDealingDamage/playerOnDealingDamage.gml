
// Perform stamina usage
if (m_isPlayer)
	m_willpush -= 1.0;

if (Settings.gameplay_mlg_farm_mode)
{
	if (m_isPlayer)
	{
		// Do some sick MLG effects
		faudio_play_sound(snd_mlgHitMarker, 100, false);
		var hitmarker = inew(o_ptcMlgHitMarker);
		hitmarker.x = x + random_range(-8, +8);
		hitmarker.y = y + random_range(-8, +8);
		effectScreenShake(3.0, 0.2, false);
	}
}