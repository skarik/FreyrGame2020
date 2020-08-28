/// @description Set up the inventory options
event_inherited();

m_name          = "Sandcakes";
m_description   = "Doesn't actually contain any sand. Warm and fluffy.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 1;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 10;