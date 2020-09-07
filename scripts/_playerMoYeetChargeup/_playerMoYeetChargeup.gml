function _playerMoYeetChargeup() {
	// Run normal motion
	_playerMotionNormal();
	// TODO: disable Z elevation collision

	var kYeetThreshold = 0.2;

	if (itemUseButton.value > 0.707)
	{
		// Increase charging
		m_isMoveCharging = true;
		m_moveCharge += Time.deltaTime * 2.0;
		m_moveCharge = saturate(m_moveCharge);
	
		// Update UI
		if (m_moveCharge >= kYeetThreshold)
		{
			m_aimingEnabled = true;
			m_aimingForce = m_moveCharge;
		}
	}
	// Button released
	else
	{
		if (m_moveCharge >= kYeetThreshold)
		{
			// Throw the payload!
			m_isMoveCharging = false;
			moScriptOverride = _playerMoYeetPayload;
		}
		else
		{
			m_isMoveCharging = false;
			moScriptOverride = null;
			m_moveCharge = 0;
		}
	
		m_aimingEnabled = false;
	}


}
