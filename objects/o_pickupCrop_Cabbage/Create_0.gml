/// @description Set up the inventory options
event_inherited();

m_name           = "Cabbage";
m_maxStack       = 10;
m_description   = "Green, leafy and not a child.";
m_onUseScript    = generalYeetableOnUse;
m_checkUseScript = nullScript;
m_tradeItem		 = [o_pickupRes_Bolt, 5];
