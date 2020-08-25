/// @description stats load

m_name = "Cortez";
m_body = 0;
m_head = 0;
m_gender = kGenderMale;
m_shirtless = false;

{
	debugOut("Randomly generating player stats");
	
	// Randomly generate gender for some variation
	m_gender = choose(kGenderMale, kGenderFemale, kGenderNonbi);
	if (m_gender == kGenderMale)
		m_name = "Cortez";
	else if (m_gender == kGenderFemale)
		m_name = "Aurum";
	else if (m_gender == kGenderNonbi)
		m_name = "Pyrite";
		
	m_body = choose(0, 1, 2);
	m_head = choose(0, 1, 2);
}

m_party = array_create(3, null);

#macro kGenderFemale 0
#macro kGenderMale 1 
#macro kGenderNonbi 2

#macro kPitemGrapple 0
#macro kPitemVoidCapacitor 1
#macro kPitemVoidAlternator 2
#macro kPitemLantern 3
#macro kPitem_MAX 16

for (var i = 0; i < kPitem_MAX; ++i)
{
	m_pitem[i] = 0;
}

m_fortune = array_create(0);
m_fortune_flipped = false;

#macro kHazardRoboVoidShot 0
#macro kHazard_MAX 256

m_hazards = array_create(kHazard_MAX, 0);


#region Progress Stats

m_times_rested = 0;

#macro kCropId_AllCrops 0
m_harvestedCrops = ds_map_create();
m_harvestedCrops[?kCropId_AllCrops] = 0;
m_harvestedCrops[?o_cropTurnip] = 0;
m_harvestedCrops[?o_cropCabbage] = 0;
m_harvestedCrops[?o_cropMelon] = 0;
m_harvestedCrops[?o_cropParsnip] = 0;
m_harvestedCrops[?o_cropPotato] = 0;
m_harvestedCrops[?o_cropEggplant] = 0;
m_harvestedCrops[?o_cropSugarCane] = 0;
m_harvestedCrops[?o_cropBamboo] = 0;
m_harvestedCrops[?o_cropTea] = 0;
m_harvestedCrops[?o_cropRice] = 0;

#endregion