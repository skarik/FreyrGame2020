/// @description Set up the inventory options
event_inherited();

m_name          = "Slime Pho";
m_description   = "Not as gross as it sounds. Has a pleasant aroma and is served cold. A summer favorte.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 1;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 15;