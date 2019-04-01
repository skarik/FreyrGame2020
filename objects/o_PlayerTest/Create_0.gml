hud = null;
quests = null;

event_inherited();

if (singleton_this()) exit;

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
quests = new(o_PlayerQuest);

// make sure there's day/night
if (!exists(o_dayNightCycle))
	new(o_dayNightCycle);
