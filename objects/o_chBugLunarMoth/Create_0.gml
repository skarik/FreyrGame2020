/// @description set height and init speed
event_inherited();

mothMotionInit();

z_height = 14;

m_lightEmissive = inew(o_lightEmissiveDepth);
m_lightEmissive.target = this;
m_lightEmissive.mask = false;

m_lightSmall = inew(o_lightCrystalSmallGentle);

m_lightSmall2 = inew(o_lightCrystalSmall);

isPassthru = true;