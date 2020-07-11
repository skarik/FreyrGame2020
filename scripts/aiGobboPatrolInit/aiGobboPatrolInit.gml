
// Set up the initial point

m_aiGobbo_centerX = xstart;
m_aiGobbo_centerY = ystart;

#macro kAiGobboPatrolState_StandCenter 0
#macro kAiGobboPatrolState_WalkOut 1
#macro kAiGobboPatrolState_StandOut 2
#macro kAiGobboPatrolState_WalkIn 3

m_aiGobbo_state = kAiGobboPatrolState_StandCenter;
m_aiGobbo_timer = 0;

aipathInit();

// Set up patrol path stuff
m_aiGobbo_patrolWaypoint = 0;
m_aiGobbo_patrol = array_create(0);
m_aiGobbo_patrolGuardpoint = null;

// Set up squad stuff

m_aiGobbo_squadSize = 0;
m_aiGobbo_squadLeader = null;
m_aiGobbo_squad = array_create(0);

m_aiGobbo_squadMember = -1;
m_aiGobbo_squadAge = 0;

m_aiGobbo_squadManage_LastSize = -1;
m_aiGobbo_squadManage_Attacker = -1;
m_aiGobbo_squadManage_MasterTimer = 0.0;
m_aiGobbo_squadManage_PositionTimer = 0.0;
m_aiGobbo_squadManage_PositionCenter = [x, y];

#macro kAiGobboSquadStateCase_Hover 0
#macro kAiGobboSquadStateCase_Hesitate 1
#macro kAiGobboSquadStateCase_AttackToHesitate 2
#macro kAiGobboSquadStateCase_AttackToHover 3

m_aiGobbo_squadStateTime = 0.0;
m_aiGobbo_squadStateCase = 0;
m_aiGobbo_squadStateTargetPosition = [x, y];