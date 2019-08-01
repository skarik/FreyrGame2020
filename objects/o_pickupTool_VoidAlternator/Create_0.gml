/// @description Set up the inventory options
event_inherited();

m_name           = "Rusted Alternator";
m_maxStack       = 1;
m_onUseScript    = grappleOnUse;
m_checkUseScript = grappleCheckUse;
m_type           = kItemPickupTool;