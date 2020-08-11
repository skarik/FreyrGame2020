/// @description Set up the inventory options
event_inherited();

m_name           = "Turnip";
m_description   = "Good for throwing, among other things."
m_maxStack       = 10;
m_onUseScript    = generalYeetableOnUse;
m_tradeItem      = [o_pickupRes_Gear, 5];