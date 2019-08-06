/// @description Set up slime

// Inherit the parent event
event_inherited();

m_team = kTeamMonster;
m_bloodType = kBloodWhite;

stats.m_health = 12.0;
stats.m_healthMax = stats.m_health;
stats.m_healthPrev = stats.m_health;

m_aiState_hangState = 0;
m_aiState_hangStartFall = false;
m_aiState_hangStartDelay = 0.0;
m_aiState_hangFallblendStart = 1.0;
m_aiState_hangFallblendValue = 0.0;

fxtimer_hangdropS = 0;
fxtimer_hangdrop = 0;

m_light = instance_create_depth(x, y, depth, o_lightCrystalSlugGlow);
m_light2 = instance_create_depth(x, y, depth, o_lightCrystalSlugGlow);

aiSlugInit();

#region Constants

kKickbackAmount = 1.0;

kMoveSpeed = 30;
kMoveSpeedStunPercent = 0.05;
kMoveSpeedWaterPercent = 0.50;

kMoveAcceleration = 800 / 8;
kMoveAccelerationStop = 500  / 8;
kMoveAccelerationAir = 200  / 8;
kMoveAccelerationAirStop = 10;

#endregion