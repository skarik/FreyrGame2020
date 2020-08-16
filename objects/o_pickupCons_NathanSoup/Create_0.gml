/// @description Set up the inventory options
event_inherited();

m_name          = "Nathan's Soup";
m_description   = "Made by a tsundere with love. Prime ingrediant is turnips.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 1;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 0;