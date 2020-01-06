/// @description set height and init speed
event_inherited();

xspeed = 1;
yspeed = 1;
random_steering = 0;

z_height = 14;

m_lightEmissive = new(o_lightEmissiveDepth);
m_lightEmissive.target = this;
m_lightEmissive.mask = false;

m_lightSmall = new(o_lightCrystalSmallGentle);

m_lightSmall2 = new(o_lightCrystalSmall);

isPassthru = true;