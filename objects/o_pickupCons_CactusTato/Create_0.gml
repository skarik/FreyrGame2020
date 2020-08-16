/// @description Set up the inventory options
event_inherited();

m_name          = "Cactus & Tato Soup";
m_description   = "Cactus & coconut milk broth with chunks of potatoe. It tastes sweet.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 1;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 1 / 2;