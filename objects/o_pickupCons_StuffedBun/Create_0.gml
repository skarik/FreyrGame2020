/// @description Set up the inventory options
event_inherited();

m_name          = "Eggy Sweet Bun";
m_description   = "It tastes like heaven. One is never enough.";
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 5;