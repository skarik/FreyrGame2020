/// @description Set up the inventory options
event_inherited();

m_name          = "Egg & Scrapple";
m_description   = "Local morning breakfast of Crull egg & Scrapple fried in slime oil. Smells pretty good.";
m_flags         = kItemFlagsConsumable;
m_maxStack      = 1;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 6;