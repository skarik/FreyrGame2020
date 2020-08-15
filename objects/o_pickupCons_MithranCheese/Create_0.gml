/// @description Set up the inventory options
event_inherited();

m_name          = "Mithran Cheese";
m_description   = "Made from Coconuts. 100% non-dairy. Mouth feel, creamy.";
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 5;