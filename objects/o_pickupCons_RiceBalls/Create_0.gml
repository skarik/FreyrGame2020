/// @description Set up the inventory options
event_inherited();

m_name          = "Rice Balls";
m_description   = "A classic. It's wrapped with something other then seaweed.";
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 1;