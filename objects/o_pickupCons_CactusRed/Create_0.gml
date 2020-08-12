/// @description Set up the inventory options
event_inherited();

m_name          = "Red Cactus Ale";
m_description   = "Brewed from cactus and red grains. Tastes like roasted peppers & chocolate. Kinda thick.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 3;