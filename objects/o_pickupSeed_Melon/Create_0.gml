/// @description Set up the inventory options
event_inherited();

m_name           = "Melon Seed";
m_maxStack       = 10;
m_onUseScript    = melonSeedOnUse;
m_checkUseScript = plantableDirtCheckUse;
m_onDepleteScript= plantableOnDeplete;
m_type           = kItemPickupSeed;