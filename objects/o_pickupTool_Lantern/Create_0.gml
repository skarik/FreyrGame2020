/// @description Set up the inventory options & make light
event_inherited();

m_name           = "Lantern";
m_maxStack       = 1;
m_onUseScript    = grappleOnUse;
m_checkUseScript = grappleCheckUse;
m_type           = kItemPickupTool;

m_light          = new(o_lightCrystalMothLanternGlow);
m_emissive       = new(o_lightEmissiveDepth_User5);
m_emissive.target = id;