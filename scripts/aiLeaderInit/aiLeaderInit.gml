function aiLeaderInit() {
#region Following States

#macro kAiLeaderState_Waiting 0
#macro kAiLeaderState_Leading 1
#macro kAiLeaderState_Backtracking 2

	m_aiLeadering = false;
	m_aiLeader_targetX = 0;
	m_aiLeader_targetY = 0;
	m_aiLeader_timer = 0.0;
	//m_aiFollow_NearTarget = 0;
	m_aiLeader_state = kAiLeaderState_Waiting;
	/*
	m_aiFollow_wanderX = 0;
	m_aiFollow_wanderY = 0;
	m_aiFollow_wanderStayTime = 0.0;

	m_aiFollow_backoffX = 0;
	m_aiFollow_backoffY = 0;*/

	kAiLeaderBeginDistance = 120;
	kAiLeaderCatchupDistance = 150;

	aipathInit();

#endregion


}
