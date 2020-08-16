/// @description Set up the inventory options
event_inherited();

m_name          = "Honey Absinthe";
m_description   = "A soup made of an assortment of veggies. Different everyday.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 1;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 1;