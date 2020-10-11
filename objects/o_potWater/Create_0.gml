event_inherited();

m_name = "Empty Water Pot";
m_actionName = "Pick Up";
m_canPickUp = true;
m_canThrow = false;
m_airFriction = 100;

filled = false;
charges = 0;
kMaxCharges = 10;

depthInit();
depthSetShadowPredrawFunction(depthShadowPredrawCircle10);
depthSetShadowDrawFunction(depthShadowDrawCircle10);

event_user(0);