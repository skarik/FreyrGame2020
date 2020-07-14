/// @description Set up the inventory options
event_inherited();

m_name          = "Cactus & Red Grain Ale";
m_description   = "Tastes like a roasted peppers & chocolate. Kinda thick.";
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;