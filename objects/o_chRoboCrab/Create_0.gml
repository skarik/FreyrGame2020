/// @description Set up robo info

// Inherit the parent event
event_inherited();

m_team = kTeamBandit;
m_bloodType = kBloodWhite;
m_dieInsteadOfKO = true;
m_canKnockout = false;

stats.m_health = 24.0;
stats.m_healthMax = stats.m_health;
stats.m_healthPrev = stats.m_health;
stats.m_stunMax = 2.0;

m_aiState_hangState = 0;
m_aiState_hangStartFall = false;
m_aiState_hangStartDelay = 0.0;
m_aiState_hangFallblendStart = 1.0;
m_aiState_hangFallblendValue = 0.0;

//fxtimer_hangdropS = 0;
//fxtimer_hangdrop = 0;

m_aiState_attackTiming = 0.0;

//m_light = instance_create_depth(x, y, depth, o_lightCrystalSlugGlow);
//m_light2 = instance_create_depth(x, y, depth, o_lightCrystalSlugGlow);

//aiSlugInit();
m_glow = inew(o_lightEmissiveDepth_User5);
m_glow.target = id;

// Set up the common code
playerInteractInit();
aiScriptableInit();
aicommonCombatInit();
aiSlugInit();

// Interact code because lazy
characterGroundInteractInit();

#region AI Constants

m_aiCombat_noticeAngle = 20;
m_aiCombat_noticeDistance = 120;

#endregion

#region Constants

kKickbackAmount = 1.0;

kMoveSpeed = 50;
kMoveSpeedStunPercent = 0.05;
kMoveSpeedWaterPercent = 0.50;

kMoveAcceleration = 800 / 2;
kMoveAccelerationStop = 500  / 2;
kMoveAccelerationAir = 200  / 2;
kMoveAccelerationAirStop = 10;

meleeAtk0Script = mvtRobocrabAttack0;
meleeAtk0Key = 0.5;
meleeAtk0Time = 1.0;

#endregion

//meleeAtk0Script

beamAtkRanges = [5, 40, 80, 120];
beamAtkWidth = 20;
beamAtkAngleOff = 10;