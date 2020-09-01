/// @description Combat Event

questSetValue(kQidIntroSequence, 100);

var item_list = [
	[o_pickupJunk_Rock, 11],
	[o_pickupCons_Berries, 1],
	[o_pickupCons_Nuts, 1],
	[o_pickupCons_MedLeaf, 3],
	[o_pickupItem_Pom, 1],
	[o_pickupMat_Scrap, 3],
	[o_pickupRes_Gear, 11],
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

instance_create_depth(68, 158, 0, o_PlayerTest);

transition_to(rm_fools_march);