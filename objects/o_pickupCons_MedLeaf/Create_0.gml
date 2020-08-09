/// @description Set up the inventory options
event_inherited();

m_name          = "Medicinal Leaf";
m_description   = "Incredibly bitter. Tastes strongly of misery.";
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;