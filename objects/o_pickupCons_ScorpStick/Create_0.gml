/// @description Set up the inventory options
event_inherited();

m_name          = "Scorp On A Stick";
m_description   = "A deeply spiced kebab; cooked over an open flame. The left over poison adds a bit of a kick.";
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;