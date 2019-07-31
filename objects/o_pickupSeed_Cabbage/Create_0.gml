/// @description Set up the inventory options
event_inherited();

m_name           = "Cabbage Seed";
m_maxStack       = 10;
m_onUseScript    = cabbageSeedOnUse;
m_checkUseScript = plantableDirtCheckUse;
m_onDepleteScript= plantableOnDeplete;
m_type           = kItemPickupSeed;