#region Following States

#macro kAiFollowState_Waiting 0
#macro kAiFollowState_Following 1
#macro kAiFollowState_Wandering 2
#macro kAiFollowState_BackingOff 3
#macro kAiFollowState_FarWatch 4
#macro kAiFollowState_AvoidAllCharacters 5
#macro kAiFollowState_AvoidAndSeekHidePoints 6

m_aiFollowing = false;
m_aiFollow_targetX = 0;
m_aiFollow_targetY = 0;
m_aiFollow_timer = 0.0;
m_aiFollow_state = kAiFollowState_Waiting;

m_aiFollow_wanderX = 0;
m_aiFollow_wanderY = 0;
m_aiFollow_wanderStayTime = 0.0;

m_aiFollow_backoffX = 0;
m_aiFollow_backoffY = 0;

m_aiFollow_cachedAvoidCharacter = null;
m_aiFollow_hidePointsBurnt = [];
m_aiFollow_hidePoint = null;

m_aiFollow_farmingCooldown = 0.0;
m_aiFollow_combatCooldown = 0.0;

m_aiFollow_watchX = 0;
m_aiFollow_watchY = 0;

kAiFollowBeginDistance = 100;
kAiFollowCatchupDistance = 60;
kAiFollowHiddenDistance = 30;
kAiFollowHideDuringCombat = false;

aipathInit();

#endregion