/// @description Set up the inventory options
event_inherited();

m_name           = "Potato";
m_description   = "If it's not green, it's safe to eat.";
m_maxStack       = 10;
m_onUseScript    = generalYeetableOnUse;
m_worthInGears   = 1;