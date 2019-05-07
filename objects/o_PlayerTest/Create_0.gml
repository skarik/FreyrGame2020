if (singleton_this()) exit;

event_inherited();

// override chracter value
m_isPlayer = true;

m_team = kTeamGood;

controlInit();

playerMotionInit();
playerAnimInit();
playerInteractInit();

camPlayerInit();

hud = new(o_PlayerHud);
inventory = new(o_inventory);
if (!exists(o_PlayerQuest))
	quests = new(o_PlayerQuest);
else
	quests = instance_find(o_PlayerQuest, 0);

// make sure there's day/night
if (!exists(o_dayNightCycle))
	new(o_dayNightCycle);


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
kDashDistance = 48;
kDashTime = 0.3;
kDashCooldown = 0.5;
kDashInAir = true;

#endregion