
#region Following States

#macro kAiFollowState_Waiting 0
#macro kAiFollowState_Following 1
#macro kAiFollowState_Wandering 2
#macro kAiFollowState_BackingOff 3

m_aiFollowing = true;
m_aiFollow_targetX = 0;
m_aiFollow_targetY = 0;
m_aiFollow_timer = 0.0;
//m_aiFollow_NearTarget = 0;
m_aiFollow_state = kAiFollowState_Waiting;

m_aiFollow_wanderX = 0;
m_aiFollow_wanderY = 0;
m_aiFollow_wanderStayTime = 0.0;

m_aiFollow_backoffX = 0;
m_aiFollow_backoffY = 0;

kAiFollowBeginDistance = 100;
kAiFollowCatchupDistance = 60;

#endregion