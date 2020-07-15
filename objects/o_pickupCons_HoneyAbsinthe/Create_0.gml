/// @description Set up the inventory options
event_inherited();

m_name          = "Honey Absinthe";
m_description   = "A sweet & golden Absinthe. It tastes like licorice and sweet almonds.";
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;