/// @description set height and init speed
event_inherited();

mothMotionInit();

hoverHasPosition = false;
hoverAreaX = room_width * 0.5;
hoverAreaY = room_height * 0.5;
hoverResetTimer = 0;

z_height = 14;

m_lightEmissive = new(o_lightEmissiveDepth);
m_lightEmissive.target = this;
m_lightEmissive.mask = false;

m_lightSmall = new(o_lightCrystalSmallGentle);

m_lightSmall2 = new(o_lightCrystalSmall);

isPassthru = true;