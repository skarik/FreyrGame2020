/// @description Set up the inventory options
event_inherited();

m_name           = "Sugar Cane";
m_description   = "Will rot your teeth. Has many uses."
m_maxStack       = 10;
//m_onUseScript    = generalYeetableOnUse;
m_tradeItem      = [o_pickupRes_Gear, 3];
m_worthInGears   = 3;