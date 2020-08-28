/// @description Set up the inventory options
event_inherited();

m_name          = "Pom & Nuts";
m_description   = "A dish of pomegrante and hearty nuts. It is simple but healthy.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 1;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 8;