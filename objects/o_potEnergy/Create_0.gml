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
depthSetShadowPredrawFunction(depthShadowPredrawCircle10);
depthSetShadowDrawFunction(depthShadowDrawCircle10);

function depthWorldDraw_PotEnergy()
{
	image_index = 1;
	depthWorldDrawSelf();

	var dx, dy;
	dx = round(x) - 0.5;
	dy = round(y) - 3;
	draw_set_color(c_white);
	draw_circle(dx, round(dy - z_height), round(energyPower * 4.0), false);
	draw_circle(dx, round(dy - z_height), round(energyPower * 6.0), true);

	draw_sprite_ext(sprite_index, 2,
					round(x),
					round(round(y) - z_height),
					image_xscale, image_yscale,
					image_angle,
					image_blend, image_alpha);
	draw_sprite_ext(sprite_index, 3,
					round(x),
					round(round(y) - z_height),
					image_xscale, image_yscale,
					image_angle,
					image_blend, image_alpha);

}
depthSetWorldDrawFunction(depthWorldDraw_PotEnergy);

//event_user(0);

m_light = inew(o_lightCrystalSmallGentle);
m_light.image_alpha = 0.0;
m_emissive = inew(o_lightEmissiveDepth_User5);
m_emissive.target = id;
m_emissive.mask = false;