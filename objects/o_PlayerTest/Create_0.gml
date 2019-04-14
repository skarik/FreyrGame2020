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
