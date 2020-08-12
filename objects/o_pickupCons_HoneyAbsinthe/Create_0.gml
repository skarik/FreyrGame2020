/// @description Set up the inventory options
event_inherited();

m_name          = "Honey Absinthe";
m_description   = "A sweet & golden absinthe. Tastes like licorice and caramel almonds.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 7;