/// @description Set up gobbo

playerMotionInit();
characterGroundInteractInit();

// Inherit the parent event
event_inherited();

#region Constants

kMoveSpeed = 60;
kMoveSpeedStunPercent = 1.0;
kMoveSpeedStunAirPercent = 1.0;
kMoveSpeedWaterPercent = 0.50;
kMoveSpeedBlockingPercent = 0.50;
kMoveSpeedCarryingPercent = 0.50;
kMoveSpeedDeathtarPercent = 0.25;

/*
kMoveAcceleration = 800;
kMoveAccelerationStop = 500;
kMoveAccelerationAir = 200;
kMoveAccelerationAirStop = 10;
kMoveAccelerationStunned = 30;
kMoveAccelerationAirStunned = 15;

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
kAnimAttack1 = sprite_index;
kAnimStun = sprite_index;
kAnimKOed = sprite_index;

// Special anim used by gobbo AI
kAnimSignal = sprite_index;

kAnimFightStomp = s_charGobHeavy0Jump;

#endregion

m_team = kTeamGobbo;
m_bloodType = kBloodRed;

stats.m_health = 64.0;
stats.m_healthMax = stats.m_health;
stats.m_healthPrev = stats.m_health;

stats.m_stunMax = 10.0;

aiScriptableInit();
kAiScriptDefaultStyle = kAiStyle_Custom;
m_aiCustom_Script = aiGobboPatrolUpdate;
aiGobboPatrolInit();
m_aiGobbo_squadPosition = kAiGobboSquadPosition_Bruiser;
m_aiGobbo_angryOverride = aiGobboHeavySquadAngryUpdate;

// Queue up the angry state
alarm[0] = 4;

image_alpha = 0.0;

// Other objects
m_colliders = [];