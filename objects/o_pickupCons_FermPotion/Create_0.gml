/// @description Set up the inventory options
event_inherited();

m_name          = "Fermented Potion";
m_description   = "Tastes like an old penny; could really use a chaser.";
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;