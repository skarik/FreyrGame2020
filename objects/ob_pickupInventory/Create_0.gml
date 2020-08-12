/// @description Set up the inventory options
event_inherited();

m_name           = "Generic Pickup";
m_description    = "Generic description.";
m_flags          = kItemFlagsNone;
m_maxStack       = 10;
m_onUseScript    = itemNullScript;
m_checkUseScript = itemNullScript;
m_onDepleteScript= itemNullScript;
m_onUiScript     = itemNullUiScript;
m_type           = kItemPickupNormal;
m_tradeItem      = [object_index, 1];
m_worthInGears   = 1;
m_userInfo       = 0;
m_userInfoString = "";