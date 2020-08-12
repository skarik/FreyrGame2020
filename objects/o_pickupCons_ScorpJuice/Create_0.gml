/// @description Set up the inventory options
event_inherited();

m_name          = "Scorpion Juice";
m_description   = "It's very red. Tastes like oysters.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 4;