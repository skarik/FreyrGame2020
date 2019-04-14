/// @description Set up the inventory options
event_inherited();

m_name           = "Turnip Seed";
m_maxStack       = 10;
m_onUseScript    = turnipSeedOnUse;
m_checkUseScript = turnipSeedCheckUse;
m_type           = kItemPickupSeed;