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
depthSetShadowPredrawFunction(depthShadowPredrawCircle10);
depthSetShadowDrawFunction(depthShadowDrawCircle10);

function depthWorldDraw_PotEnergyPlug()
{
	depthWorldDrawSelf();
	var dx, dy;
	dx = round(x);
	dy = round(y) - 13;
	draw_set_color(c_white);
	draw_circle(dx, round(dy - z_height), round(energyPower * 5.0), false);
	draw_circle(dx, round(dy - z_height), round(energyPower * 7.0), true);
}
depthSetWorldDrawFunction(depthWorldDraw_PotEnergyPlug);

//event_user(0);

m_light = inew(o_lightCrystalSmallGentle);
m_light.image_alpha = 0.0;