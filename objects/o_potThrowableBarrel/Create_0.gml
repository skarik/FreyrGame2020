event_inherited();

m_name = "Small Barrel";
m_actionName = "Pick Up";
m_canPickUp = true;
m_canThrow = true;
m_airFriction = 100;

/*m_moving = false;
xspeed = 0;
yspeed = 0;
zspeed = 0;
zgravity = 200;
kGroundFriction = 600;
m_onGround = false;*/

depthInit();
depthSetShadowPredrawFunction(depthShadowPredrawCircle10);
depthSetShadowDrawFunction(depthShadowDrawCircle10);

// For the damage calculations
m_isPlayer = false;
m_team = 0;
isBlocking = false;
isDashing = false;
isEthereal = false;