event_inherited();

m_name = "Energy Pot";
m_actionName = "Pick Up";
m_canPickUp = true;
m_canThrow = false;
m_airFriction = 100;

energyPower = 0.0;
energyFade = false;
energyPlugged = false;

// Used in tower for no-magic zone
overcharge = 0.0;
overcharge_ptc_counter = 0.0;

depthInit();

//event_user(0);

m_light = new(o_lightCrystalSmallGentle);
m_light.image_alpha = 0.0;