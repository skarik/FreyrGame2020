/// @description Vendor Demo

questSetValue(kQidIntroSequence, 1000);
questSetValue(kQidMithraEscape, 30);
questSetValue(kQidFoolsTower, 40);

var item_list = [
	[o_pickupCrop_Turnip, 21],
	[o_pickupJunk_Rock, 14],
	[o_pickupCons_Nuts, 1],
	[o_pickupCons_MedLeaf, 1],
	[o_pickupItem_Pom, 1],
	[o_pickupRes_Gear, 10],
	[o_pickupRes_Bolt, 8],
	[o_pickupRes_BoneShard, 7],
	[o_pickupRes_VoidShard, 3],
	[o_pickupSeed_Turnip, 5],
	[o_pickupItem_CrullEgg, 4],
	[o_pickupMat_Scrap, 14],
	[o_pickupJunk_Spork, 1],
	[o_pickupCrop_Parsnip, 8],
	];
	
for (var i = 0; i < array_length_1d(item_list); ++i)
{
	var itemEntry = item_list[i];
	
	var seed = inew(itemEntry[0]);
		seed.persistent = true;
		seed.m_pickupTarget = o_PlayerTest;
		seed.m_isPickingUp = true;
		seed.m_count = itemEntry[1];
		seed.m_allowOnBelt = false;
}

inew_unique(o_dayNightCycle);
o_dayNightCycle.m_day += 1;

instance_create_depth(570, 1835, 0, o_PlayerTest);

transition_to(rm_mithra);