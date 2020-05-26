/// @description Set up the inventory options
event_inherited();

m_name           = "Bamboo Shoot";
m_description   = "Can be planted or used for recipes."
m_maxStack       = 99;
m_onUseScript    = generalSeedOnUse;
m_checkUseScript = plantableDirtCheckUse;
m_onDepleteScript= plantableOnDeplete;
m_type           = kItemPickupSeed;
m_userInfo       = o_cropBamboo;
m_userInfoString = object_get_name(m_userInfo);