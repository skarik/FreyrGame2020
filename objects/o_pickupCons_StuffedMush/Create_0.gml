/// @description Set up the inventory options
event_inherited();

m_name          = "Stuffed-Mush Soup";
m_description   = "A mushroom filled with mushroom broth. Mushception.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 1;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 6;