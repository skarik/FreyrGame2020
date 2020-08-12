/// @description Set up the inventory options
event_inherited();

m_name           = "Tea Leaves";
m_description   = "Has many uses. Smells minty fresh."
m_maxStack       = 10;
//m_onUseScript    = generalYeetableOnUse;
m_tradeItem      = [o_pickupRes_Gear, 3];
m_worthInGears   = 3;