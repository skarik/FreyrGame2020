/// @description WIP: Grapple

questSetValue(kQidIntroSequence, 1000);
questSetValue(kQidMithraEscape, 30);
questSetValue(kQidFoolsTower, 20);

var item_list = [
	[o_pickupTool_Grapple, 1],
	[o_pickupJunk_Rock, 3],
	[o_pickupCons_Nuts, 1],
	[o_pickupCons_MedLeaf, 1],
	[o_pickupItem_Pom, 1],];
	
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
o_dayNightCycle.m_day += 3;
o_dayNightCycle.m_timeOfDay = 14;

instance_create_depth(360, 800, 0, o_PlayerTest);

transition_to(rm_fools_march_north);