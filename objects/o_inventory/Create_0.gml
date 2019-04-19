/// @description Initialize empty belt

//for (var i = 0; i < belt_size; ++i)
//{
//	belt[i] = itemEntryNew();
	/*belt_object[i] = null
	belt_count[i] = 0;
	belt_name[i] = "";
	belt_checkUse[i] = nullScript;
	belt_onUse[i] = nullScript;
	belt_type[i] = kItemPickupNormal;*/
//}

belt_size = 6;
belt = itemArrayCreate(belt_size);
belt_selection = 0;

seed_size = 18;
seed = itemArrayCreate(seed_size);

bag_size = 23;
bag = itemArrayCreate(bag_size);

