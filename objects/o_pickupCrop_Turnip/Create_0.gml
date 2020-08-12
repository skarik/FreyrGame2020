/// @description Set up the inventory options
event_inherited();

m_name           = "Turnip";
m_description    = "Good for throwing, sometimes good for eating.";
m_flags          = kItemFlagsYeetable;
m_maxStack       = 10;
m_onUseScript    = generalYeetableOnUse;
m_tradeItem      = [o_pickupRes_Gear, 1];
m_worthInGears   = 1;