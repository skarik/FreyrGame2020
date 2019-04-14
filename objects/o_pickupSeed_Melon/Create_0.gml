/// @description Set up the inventory options
event_inherited();

m_name           = "Melon Seed";
m_maxStack       = 10;
m_onUseScript    = melonSeedOnUse;
m_checkUseScript = turnipSeedCheckUse;
m_type           = kItemPickupSeed;