// Set up the initial point
m_aiNPC_centerX = xstart;
m_aiNPC_centerY = ystart;

// Define (not alert & not angry behavior)
#macro kAiNPCGuardState_PreInit 0
#macro kAiNPCGuardState_Stand 1
#macro kAiNPCGuardState_Walk 2
#macro kAiNPCGuardState_Talk 3
#macro kAiNPCGuardState_DefinedGuard 8
#macro kAiNPCGuardState_DefinedPatrol 9

// Patrolling (not alert & not angry behavior)
m_aiNPC_state = kAiNPCGuardState_PreInit;
m_aiNPC_timer = 0;

m_aiNPC_patrolPathnode = null;
m_aiNPC_patrolGuardpoint = null;
m_aiNPC_timer = 0.0;
aipathInit();

m_aiNPC_patrolWalkSpeed = 0.5;

m_aiNPC_patrolNextWalkSimple = kTristateUnknown;


#macro kTristateUnknown -1
#macro kTristateFalse 0
#macro kTristateTrue 1


#macro kAiNPCAlertState_Notice 0
#macro kAiNPCAlertState_Investigate 1
#macro kAiNPCAlertState_Pause 2

m_aiNPC_alertState = kAiNPCAlertState_Notice;
m_aiNPC_alertTimer = 0.0;
m_aiNPC_alertFacing = 0.0;
m_aiNPC_alertPosition = [0, 0];
m_aiNPC_fastAggro = false;