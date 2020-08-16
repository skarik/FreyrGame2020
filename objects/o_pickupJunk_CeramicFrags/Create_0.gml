/// @description Set up the inventory options
event_inherited();

m_name           = "Ceramic Fragments";
m_description	 = "Evidence of a smashed pot. 20 years bad luck for anyone dressed in green.";
m_flags          = kItemFlagsYeetable;
m_maxStack       = 20;
m_onUseScript    = generalYeetableOnUse;
m_type           = kItemPickupNormal;
m_worthInGears   = 1 / 13;