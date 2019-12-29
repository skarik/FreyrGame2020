/// @description Set up the inventory options
event_inherited();

m_name           = "Dried Meats";
m_description    = "Tough mystery meat, dried to preserve it. Tastes like fried potatoes.";
m_maxStack       = 10;
m_type           = kItemPickupNormal;
m_onUiScript     = generalConsumableOnUi;