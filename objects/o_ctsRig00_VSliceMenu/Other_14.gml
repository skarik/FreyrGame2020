/// @description Stealth event

questSetValue(kQidIntroSequence, 1000);
questSetValue(kQidMithraEscape, 10);

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

instance_create_depth(1472, 286, 0, o_PlayerTest);

transition_to(rm_mithra);