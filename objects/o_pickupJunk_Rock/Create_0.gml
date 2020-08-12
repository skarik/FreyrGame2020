/// @description Set up the inventory options
event_inherited();

m_name           = "Rock";
m_description	 = "A small rock, no doubt stolen from somewhere.";
m_flags          = kItemFlagsYeetable;
m_maxStack       = 20;
m_onUseScript    = generalYeetableOnUse;
m_type           = kItemPickupNormal;
m_worthInGears   = 1 / 15;