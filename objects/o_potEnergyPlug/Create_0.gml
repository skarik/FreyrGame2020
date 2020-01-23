event_inherited();

m_name = "Energy Plug";
m_actionName = "Pick Up";
m_canPickUp = true;
m_canThrow = false;
m_airFriction = 100;

energyPower = 0.0;
energyPlugged = false;

// Check if already plugged in
if (energyPlugId == null && place_meeting(x, y, o_livelyPoweredPotPlug))
{
	energyPlugId = collision_point(x, y, o_livelyPoweredPotPlug, false, true);
}
// If plugged in, run plug logic.
if (energyPlugId != null)
{
	energyPlugged = true;
	x = energyPlugId.x;
	y = energyPlugId.y;
	energyPlugId.m_pot = id;
}

depthInit();

//event_user(0);

m_light = new(o_lightCrystalSmallGentle);
m_light.image_alpha = 0.0;