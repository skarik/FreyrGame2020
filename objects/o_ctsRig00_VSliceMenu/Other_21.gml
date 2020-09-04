/// @description WIP: Tower 2

questSetValue(kQidIntroSequence, 1000);
questSetValue(kQidMithraEscape, 30);
questSetValue(kQidFoolsTower, 20);

var item_list = [
	[o_pickupJunk_Rock, 3],
	[o_pickupCons_Nuts, 1],
	[o_pickupCons_MedLeaf, 1],
	[o_pickupItem_Pom, 1],
	[o_pickupRes_Gear, 16],
	[o_pickupSeed_Turnip, 5],];
	
for (var i = 0; i < array_length_1d(item_list); ++i)
{
	var itemEntry = item_list[i];
	
	var seed = inew(itemEntry[0]);
		seed.persistent = true;
		seed.m_pickupTarget = o_PlayerTest;
		seed.m_isPickingUp = true;
		seed.m_count = itemEntry[1];
}

inew_unique(o_dayNightCycle);
o_dayNightCycle.m_day += 2;
o_dayNightCycle.m_timeOfDay = 7;

//instance_create_depth(570, 1835, 0, o_PlayerTest);

transition_to(rm_fools_tower2);