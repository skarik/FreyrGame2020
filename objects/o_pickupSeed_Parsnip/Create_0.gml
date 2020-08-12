/// @description Set up the inventory options
event_inherited();

m_name           = "Parsnip Seed";
m_description   = "Seeds are meant to be planted. Still a fraud even as a seed."
m_maxStack       = 99;
m_onUseScript    = generalSeedOnUse;
m_checkUseScript = plantableDirtCheckUse;
m_onDepleteScript= plantableOnDeplete;
m_type           = kItemPickupSeed;
m_worthInGears   = 1 / 3;
m_userInfo       = o_cropParsnip;
m_userInfoString = object_get_name(m_userInfo);