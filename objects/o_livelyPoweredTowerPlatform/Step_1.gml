/// @description Update motion & elevation area

// Update power first:
if (m_powerOutput > 0.5)
	m_lightingPower = motion1d_to(m_lightingPower, saturate(m_powerOutput), 1.1 * Time.deltaTime);
else
	m_lightingPower = motion1d_to(m_lightingPower, saturate(m_powerOutput), 2.0 * Time.deltaTime);

// Move to the current point
if (m_currentPathNode == null)
{
	m_currentPathNode = m_firstPathNode;
	if (iexists(m_currentPathNode))
	{
		x = m_currentPathNode.x;
		y = m_currentPathNode.y + z_height;
	}
}
if (m_powerOutput > 0.5 && iexists(m_currentPathNode))
{
	if (m_waitingForNode)
	{
		// Count down waiting for the node
		m_waitingForNodeTime -= Time.deltaTime;
		if (m_waitingForNodeTime <= 0.0)
			m_waitingForNode = false;
	}
	else if (m_waitingForRider)
	{
		// First wait for the rider to get off
		if (m_waitingForRiderIgnoreWeight)
		{
			if (!place_meeting(x, y - z_height, ob_character))
				m_waitingForRiderIgnoreWeight = false;
		}
		// Now wait for rider to get back on
		else
		{
			// Check for colliding with character once character leaves
			if (place_meeting(x, y - z_height, ob_character))
			{
				m_waitingForRider = false; // Let's get started moving!
				m_waitingForRiderDelay = 0.5; // (but with a small delay)
			}
		}
	}
	else if (m_waitingForRiderDelay > 0.0)
	{
		m_waitingForRiderDelay -= Time.deltaTime; // Count down normally.
	}
	else
	{
		var move_dist = m_moveSpeed * Time.deltaTime * m_currentPathNode.m_pathSpeed;
		var dist = point_distance(x, y, m_currentPathNode.x, m_currentPathNode.y + z_height);
	
		// Move to the node
		if (dist > move_dist)
		{
			x += (m_currentPathNode.x - x) / dist * move_dist;
			y += (m_currentPathNode.y - y + z_height) / dist * move_dist;
		}
		else
		// Hit the node
		{
			x = m_currentPathNode.x;
			y = m_currentPathNode.y + z_height;
		
			// Do we pause motion here? (Is it a stop)
			if (m_currentPathNode.m_pathForceStop)
			{
				m_waitingForRider = true;
				m_waitingForRiderIgnoreWeight = true;
				m_waitingForRiderDelay = 0.0;
			}
			// Do we pause here?
			if (m_currentPathNode.m_pathPauseTime > 0.0)
			{
				m_waitingForNode = true;
				m_waitingForNodeTime = m_currentPathNode.m_pathPauseTime;
			}
		
			// Else, go to next node
			m_currentPathNode = m_currentPathNode.m_pathNext;
		}
	}
}

// Update elevation area:
platform3_set_xyzh(m_elevation, x, y, z, z_height);