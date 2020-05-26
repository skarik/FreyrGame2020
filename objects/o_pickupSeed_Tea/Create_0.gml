/// @description Set up the inventory options
event_inherited();

m_name           = "Tea Seeds";
m_description   = "Seeds are meant to be planted."
m_maxStack       = 99;
m_onUseScript    = generalSeedOnUse;
m_checkUseScript = plantableDirtCheckUse;
m_onDepleteScript= plantableOnDeplete;
m_type           = kItemPickupSeed;
m_userInfo       = o_cropTea;
m_userInfoString = object_get_name(m_userInfo);