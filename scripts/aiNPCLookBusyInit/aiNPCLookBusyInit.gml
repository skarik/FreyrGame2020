
// Set up the initial point

m_aiNPC_centerX = xstart;
m_aiNPC_centerY = ystart;

#macro kAiNPCPatrolState_Stand 0
#macro kAiNPCPatrolState_Walk 1
#macro kAiNPCPatrolState_Talk 2
#macro kArrivalDistance 10

m_aiNPC_state = kAiNPCPatrolState_Stand;
m_aiNPC_prev_state = kAiNPCPatrolState_Stand;
m_aiNPC_timer = 0;
aipathInit();

// Set up patrol path stuff
m_aiNPC_patrolWaypoint = 0;
m_aiNPC_patrol = array_create(0);