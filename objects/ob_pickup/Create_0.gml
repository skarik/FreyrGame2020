depthInit();
z_height = 18;

m_canPickUp = true;
m_isPickingUp = false;
m_pickupTarget = null;

m_pickupTimer = 0.0;
m_pickupStartX = x;
m_pickupStartY = y;

m_pickupSpeedX = 0.0;
m_pickupSpeedY = 0.0;

m_pickupCooldown = 0.0;

#macro kPickupTime 0.3
#macro kPickupAcceleration 100
#macro kPickupCurvePower 4.0