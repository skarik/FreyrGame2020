var patrol_length = array_length_1d(m_aiNPC_patrol);

//Check for talky things going on
if (m_interactionObject.m_interacting) 
{
	_controlStructUpdate(xAxis, 0.0);
	_controlStructUpdate(yAxis, 0.0);

	if (m_aiNPC_state != kAiNPCPatrolState_Talk) {
		m_aiNPC_prev_state = m_aiNPC_state;
		m_aiNPC_state = kAiNPCPatrolState_Talk;	
	}
}
else
{
	if (m_aiNPC_state == kAiNPCPatrolState_Talk)
	{
		var swap = m_aiNPC_state;
		m_aiNPC_state = m_aiNPC_prev_state;	
		m_aiNPC_prev_state = swap;
	}
}

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
		m_aiNPC_patrolWaypoint = (m_aiNPC_patrolWaypoint + 1) % 2;
	}
}

// Move to the target
if (m_aiNPC_state == kAiNPCPatrolState_Walk)
{
	m_aiNPC_timer += Time.deltaTime;
	var patrol_point = m_aiNPC_patrol[m_aiNPC_patrolWaypoint];
	aipathMoveTo(patrol_point[0], patrol_point[1]);

	// Done walking to the next spot, stand around a bit
	if (point_distance(patrol_point[0], patrol_point[1], x, y) < kArrivalDistance)
	{	
		m_aiNPC_timer = 0.0;
		m_aiNPC_state = kAiNPCPatrolState_Stand;
	}
}