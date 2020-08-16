/// @description Set up the inventory options
event_inherited();

m_name          = "Scorpion on a Stick";
m_description   = "A deeply spiced kebab, cooked over an open flame. The leftover poison adds a kick.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 3;