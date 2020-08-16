/// @description Set up the inventory options
event_inherited();

m_name          = "Coconut Milk";
m_description   = "Made by shredding coconut into boiling water and straining through a cheesecloth.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 5;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 5;