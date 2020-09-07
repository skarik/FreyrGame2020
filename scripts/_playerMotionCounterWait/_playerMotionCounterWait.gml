function _playerMotionCounterWait() {

	// start the counter if there is no freeze

	if (!iexists(m_perfectCounterFreezer))
	{
		// Wait until we're not dashing...
		if (isDashing)
		{
			_playerMotionDashing();
		}
		else
		{
			m_perfectCounterFreezer = inew(o_timefxFader);
			m_perfectCounterFreezer.m_multiplierTarget = 0.1;
			m_perfectCounterFreezer.m_fadeSpeed = 4.0;
	
			m_perfectCounterFocuser = inew(o_fxCounterFocus);
			m_perfectCounterFocuser.m_source = id;
			m_perfectCounterFocuser.m_target = m_perfectCounterTarget;
	
			m_perfectCounterTimer = 0.0;
		}
	}
	else
	{
		// Let's get to business.
		_playerMotionNormal();
		/*moScriptOverride = null;
		playerMotionStep();
		moScriptOverride = _playerMotionCounterWait;*/
	
		// Check if attack 
		if (atkButton.pressed)
		{
			moScriptOverride = _playerMotionCounterSeekHit;
			m_perfectCounterTimer = 0.0; // Reset timer, as it is used for seeking.
		}
	
		// Update timer
		m_perfectCounterTimer += Time.unscaled_dt;
		if (m_perfectCounterTimer > 1.0
			|| isDashing
			|| m_isStunned || m_isKOed || m_isDead)
		{
			// Resume time
			m_perfectCounterFreezer.m_fadeIn = false;
			m_perfectCounterFreezer = null;
			moScriptOverride = null;
		
			// Kill focuser
			if (iexists(m_perfectCounterFocuser))
			{
				m_perfectCounterFocuser.m_cancelled = true;
				m_perfectCounterFocuser = null;
			}
		}
	}


}
