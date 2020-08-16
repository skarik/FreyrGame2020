/// @description Set up the inventory options
event_inherited();

m_name          = "Sweet Bun";
m_description   = "Delicious and warm. It fills you with determination.";
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 4;