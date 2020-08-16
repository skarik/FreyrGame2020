/// @description Set up the inventory options
event_inherited();

m_name          = "Stone Soup";
m_description   = "Like the story goes. It's made with a little bit of everything. Including a pebble.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 1;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 8;