var l_canMove = argument0;

if (!l_canMove)
{
	m_isVoidPunchCharging = false;
}

if (l_canMove && !m_isHolding && !m_isPlanting && !isDashing && !isBlocking && !isAttacking && !isBusyInteracting)
{
	// Charge it up!
	if (!m_isVoidPunchCharging)
	{
		if (keyItemUseButton.pressed)
		{
			if (pstats.m_pitem[kPitemVoidCapacitor] > 0 && m_voidPunch_fill > 0.0)
			{
				// for now, we hard-code the punch ability
				
				// begin charging panch
				m_isVoidPunchCharging = true;
				m_voidPunch_charged = 0.0;
			}
			else
			{
				audio_play_sound(snd_UIOnUse, 0, false);
			}
		}
	}
	// Has been charging
	else
	{
		m_voidPunch_charged = saturate(m_voidPunch_charged + Time.deltaTime * 2.0);
		
		// PANCH
		if (keyItemUseButton.released)
		{
			// Reset all the timers
			dashTimer = 0.0; // We use the dash timer for all the behavior here.

			// Play audio
			var audio = sound_play_at(x, y, snd_GrappleFire);
				audio.pitch = 0.8;
				audio.gain = 0.6;
				
			// no longer charging
			m_isVoidPunchCharging = false;

			// Set the new script
			moScriptOverride = _playerMotionVoidPunch;
		}
	}
}