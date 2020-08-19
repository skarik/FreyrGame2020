/// @description Set up gobbo

playerMotionInit();
characterGroundInteractInit();

// Inherit the parent event
event_inherited();

#region Constants

kMoveSpeed = 110;
kMoveSpeedStunPercent = 0.05;
kMoveSpeedWaterPercent = 0.50;
kMoveSpeedBlockingPercent = 0.50;
kMoveSpeedCarryingPercent = 0.50;
kMoveSpeedDeathtarPercent = 0.25;
/*
kMoveAcceleration = 800;
kMoveAccelerationStop = 500;
kMoveAccelerationAir = 200;
kMoveAccelerationAirStop = 10;

kDashDistance = 48;
kDashTime = 0.3;
kDashCooldown = 0.5;
kDashInAir = true;*/

#endregion

#region Attacks

meleeAtk0Time = 0.7;
meleeAtk0Hit = 0.50;
meleeAtk0Key = 0.65;
meleeAtk0Script = _characterGobboAttack0;
meleeAtk0Damage = 2;

meleeAtk1Time = 0.7;
meleeAtk1Hit = 0.50;
meleeAtk1Key = 0.65;
meleeAtk1Script = _characterGobboAttack0;
meleeAtk1Damage = 2;

meleeAtk2Time = 0.7;
meleeAtk2Hit = 0.50;
meleeAtk2Key = 0.65;
meleeAtk2Script = _characterGobboAttack0;
meleeAtk2Damage = 2;

meleeAtk3Time = 0.7;
meleeAtk3Hit = 0.50;
meleeAtk3Key = 0.65;
meleeAtk3Script = _characterGobboAttack0;
meleeAtk3Damage = 2;


#endregion

#region Animation

kAnimStanding = sprite_index;
kAnimWalking = sprite_index;
kAnimRolling = sprite_index;
kAnimAttack1 = s_charGobbo0Atk1;
kAnimStun = s_charGobbo0Stunned;
kAnimKOed = s_charGobbo0KOed;

// Special anim used by gobbo AI
kAnimSignal = s_charGobbo0Point;

#endregion

m_team = kTeamGobbo;
m_bloodType = kBloodRed;

stats.m_health = 24.0;
stats.m_healthMax = stats.m_health;
stats.m_healthPrev = stats.m_health;

stats.m_stunMax = 5.0;

aiScriptableInit();
kAiScriptDefaultStyle = kAiStyle_Custom;
m_aiCustom_Script = aiGobboPatrolUpdate;
aiGobboPatrolInit();
alarm[0] = 4;

image_alpha = 0.0;