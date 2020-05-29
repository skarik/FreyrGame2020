/// @description Set up the inventory options & make light
event_inherited();

m_name           = "Lantern";
m_maxStack       = 1;
m_type           = kItemPickupTool;

m_showPickupUI   = true;

m_light          = inew(o_lightCrystalMothLanternGlow);
m_emissive       = inew(o_lightEmissiveDepth_User5);
m_emissive.target = id;