event_inherited();

m_name = "Energy Pot";
m_actionName = "Pick Up";
m_canPickUp = true;
m_canThrow = false;
m_airFriction = 100;

/*filled = false;
charges = 0;
kMaxCharges = 10;*/
energyPower = 0.0;
energyFade = false;

depthInit();

//event_user(0);

m_light = new(o_lightCrystalSmallGentle);
m_light.image_alpha = 0.0;