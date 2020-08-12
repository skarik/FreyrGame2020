/// @description Set up the inventory options
event_inherited();


//Gives Back Stamina, Takes Away Health (Maybe fast tracks time a little like in metal gear?)
//Can Be used 1x
//requires 2x tea leaves to make

m_name          = "Tea Cigar";
m_description   = "Tea Cigar!"
m_flags         = kItemFlagsConsumable;
m_maxStack      = 10;
m_type          = kItemPickupNormal;
m_onUiScript    = generalConsumableOnUi;
m_onUseScript   = generalConsumableOnUse;
m_worthInGears  = 2;