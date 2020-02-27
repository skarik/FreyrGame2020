if (singleton_this()) exit;

event_inherited();

// override chracter value
m_isPlayer = true;

m_team = kTeamGood;
m_name = "Cortez";
m_bloodType = kBloodRedWill;

m_currentArea = kAreaNoArea;
m_currentAreaTimer = 0.0;

controlInit();

playerMotionInit();
//playerAnimInit();
characterAnimInit();
playerInteractInit();

// create scriptable vars for cutscenes
aiScriptableInit();

camera = new(o_PlayerCamera);
hud = new(o_PlayerHud);
inventory = new(o_inventory);
if (!exists(o_PlayerQuest))
	quests = new(o_PlayerQuest);
else
	quests = instance_find(o_PlayerQuest, 0);
if (!exists(o_PlayerStats))
	pstats = new(o_PlayerStats);
else
	pstats = instance_find(o_PlayerStats, 0);
// update name
m_name = pstats.m_name;

// make sure there's day/night
if (!exists(o_dayNightCycle))
	new(o_dayNightCycle);

m_prevInventoryActive = false;

m_lanternProp = null;
m_lanternLight = null;
m_lanternEmissive = null;

m_tarDeathTimer = 0.0;

m_will = 16 * 60;
m_willMax = m_will;
m_willPrevious = m_will;
m_willpush = 6;
m_willpushMax = m_willpush;
m_willpushPrevious = m_willpush;
m_willpushRegenTimer = 0.0;
m_willStyleStun = false;

m_mana = 0;
m_manaMax = 20;

m_itemBalancePivot = [x, y];
m_itemBalanceSpeed = [0, 0];

// the player alright has a character-light, but for no-ambient rooms, it gets disabled
// thus, we need a specific light that shows the character location
m_locatorLight = new(o_lightEmissiveDepth_User5);
m_locatorLight.target = id;
m_locatorSh_uColorKey = shader_get_uniform(sh_colorkeyAlphatest, "uColorKey");

#region Constants

kMoveSpeed = 120;
kMoveSpeedWaterPercent = 0.50;
kMoveSpeedBlockingPercent = 0.50;
kMoveSpeedCarryingPercent = 0.50;
kMoveSpeedDeathtarPercent = 0.25;
kMoveAcceleration = 800;
kMoveAccelerationStop = 500;
kMoveAccelerationAir = 200;
kMoveAccelerationAirStop = 10;
//kDashDistance = 48;
//kDashTime = 0.15; // movespeed of about 240
kDashDistance = 72;
kDashTime = 0.5;
kDashCooldown = 0.3;
kDashInAir = true;

#endregion

#region Sprites

kAnimStanding = s_charHeroStand;
kAnimWalking = s_charHeroWalk;
kAnimRunning = s_charHeroRun;
kAnimRolling = s_charHeroRoll;
kAnimSinkFalling = s_charHeroSinkFall;
kAnimAttack1 = s_charHeroAtk1;
kAnimDig1 = s_charHeroPunchDig;
kAnimStun = s_charHeroStunned;

#endregion

#region Melee

/*
meleeAtk0Time = 0.2;
meleeAtk0Hit = 0.05;
meleeAtk0Key = 0.10;
meleeAtk0Script = _playerAttack0;
meleeAtk0Damage = 2;

meleeAtk1Time = 0.2;
meleeAtk1Hit = 0.05;
meleeAtk1Key = 0.10;
meleeAtk1Script = _playerAttack1;
meleeAtk1Damage = 2;

meleeAtk2Time = 0.5;
meleeAtk2Hit = 0.1;
meleeAtk2Key = 0.3;
meleeAtk2Script = _playerAttack2;
meleeAtk2Damage = 2;

meleeAtk3Time = 0.4;
meleeAtk3Hit = 0.2;
meleeAtk3Key = 0.21;
meleeAtk3Script = _playerAttack3;
meleeAtk3Damage = 5;
*/

meleeAtk0Time = 0.5;
meleeAtk0Hit = 1 / 8.0 * meleeAtk0Time;// 0.05;
meleeAtk0Key = 4 / 8.0 * meleeAtk0Time;//0.10;
meleeAtk0Script = _playerAttack0;
meleeAtk0Damage = 2;

meleeAtk1Time = 0.5;
meleeAtk1Hit = 1 / 8.0 * meleeAtk1Time;//0.05;
meleeAtk1Key = 4 / 8.0 * meleeAtk1Time;//0.10;
meleeAtk1Script = _playerAttack1;
meleeAtk1Damage = 2;

meleeAtk2Time = 0.9;
meleeAtk2Hit = 0.1;
meleeAtk2Key = 0.3;
meleeAtk2Script = _playerAttack2;
meleeAtk2Damage = 2;

meleeAtk3Time = 0.7;
meleeAtk3Hit = 0.2;
meleeAtk3Key = 0.21;
meleeAtk3Script = _playerAttack3;
meleeAtk3Damage = 5;

#endregion