var patrol_length = array_length_1d(m_aiNPC_patrol);

//Stand around for a bit.
if (m_aiNPC_state == kAiNPCPatrolState_Stand)
{
	_controlStructUpdate(xAxis, 0.0);
	_controlStructUpdate(yAxis, 0.0);

	m_aiNPC_timer += Time.deltaTime;
	if (m_aiNPC_timer > 3.0)
	{
		m_aiNPC_timer = 0.0;
		m_aiNPC_state = kAiNPCPatrolState_Walk;
		m_aiNPC_patrolWaypoint = 1;
	}
}

// Move to the target
if (m_aiNPC_state == kAiNPCPatrolState_Walk)
{
	// Stop motion if not been 1 second
	/*if (m_aiNPC_timer < 1.0)
	{
		_controlStructUpdate(xAxis, 0.0);
		_controlStructUpdate(yAxis, 0.0);
		
		var patrol_point = m_aiNPC_patrol[m_aiNPC_patrolWaypoint];
		aimotionFaceAt(patrol_point[0], patrol_point[1], 180);
	}*/

	m_aiNPC_timer += Time.deltaTime;

	// If after a second, begin that waypoint follow
	if (m_aiNPC_timer > 3.0)
	{
		var patrol_point = m_aiNPC_patrol[m_aiNPC_patrolWaypoint];
	
		// Move to the patrol target
		aipathMoveTo(patrol_point[0], patrol_point[1]);
	
		// If at the patrol point, move to the next point
		m_aiNPC_timer = 0.0;
		m_aiNPC_patrolWaypoint = 0;
		//m_aiNPC_state = kAiNPCPatrolState_Stand;
	}
}