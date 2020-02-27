/// @description Set up the inventory options
event_inherited();

m_name           = "Melon";
m_maxStack       = 10;

m_onUseScript    = generalYeetableOnUse;
m_checkUseScript = nullScript;
m_tradeItem		 = [o_pickupItem_CrullEgg, 1];
