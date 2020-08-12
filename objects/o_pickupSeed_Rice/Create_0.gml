/// @description Set up the inventory options
event_inherited();

m_name           = "Rice Seed";
m_description   = "Seeds are meant to be planted."
m_maxStack       = 99;
m_onUseScript    = generalSeedOnUse;
m_checkUseScript = plantableWaterCheckUse;
m_onDepleteScript= plantableOnDeplete;
m_type           = kItemPickupSeed;
m_worthInGears   = 1 / 3;
m_userInfo       = o_cropRice;
m_userInfoString = object_get_name(m_userInfo);