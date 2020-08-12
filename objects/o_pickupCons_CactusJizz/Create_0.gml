/// @description Set up the inventory options
event_inherited();

m_name          = "Cactus Jizz";
m_description   = "It's thick and goopy. Tastes clean and grassy, but leaves your tongue prickling.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 4;