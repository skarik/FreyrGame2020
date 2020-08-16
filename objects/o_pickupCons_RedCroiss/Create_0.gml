/// @description Set up the inventory options
event_inherited();

m_name          = "Red Croissant ";
m_description   = "Flakey and warm. It would be good with butter.";
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 3;