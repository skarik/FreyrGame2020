controlInit();

playerMotionInit();
playerAnimInit();
playerInteractInit();

camPlayerInit();

stats = new(o_stats);
hud = new(o_PlayerHud);
inventory = new(o_inventory);

// make sure there's day/night
if (!exists(o_dayNightCycle))
	new(o_dayNightCycle);