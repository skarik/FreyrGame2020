/// @description Get Farming

questSetValue(kQidIntroSequence, 1000);
questSetValue(kQidMithraEscape, 30);
questSetValue(kQidFoolsTower, 40);

var item_list = [
	[o_pickupSeed_Turnip, 15],
	[o_pickupSeed_Cabbage, 5],
	[o_pickupSeed_Melon, 5],
	[o_pickupSeed_Eggplant, 8],
	[o_pickupSeed_Parsnip, 1],
	[o_pickupItem_CrullEgg, 1]];
	
for (var i = 0; i < array_length_1d(item_list); ++i)
{
	var itemEntry = item_list[i];
	
	var seed = inew(itemEntry[0]);
		seed.persistent = true;
		seed.m_pickupTarget = o_PlayerTest;
		seed.m_isPickingUp = true;
		seed.m_count = itemEntry[1];
}

room_goto(rm_oasis_farm);