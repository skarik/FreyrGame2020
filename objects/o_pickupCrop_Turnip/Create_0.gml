/// @description Set up the inventory options
event_inherited();

m_name           = "Turnip";
m_maxStack       = 10;
m_onUseScript    = turnipOnUse;
m_tradeItem      = [o_pickupRes_Gear, 5];