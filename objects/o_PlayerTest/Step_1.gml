/// @description On Hurt effects

// Create screen shake and other On-hurt effects
if ( m_isPlayer && stats.m_health < stats.m_healthPrev )
{
    var damage_gradient = (stats.m_healthPrev - stats.m_health) * (100 / stats.m_healthMax);
	if (m_lastDamage != kDamageTypeTar)
	{
	    effectScreenShake(
	        1 + floor(damage_gradient * 0.25),
	        0.3 + floor(damage_gradient) * 0.05,
	        true);
	}
    effectControllerShake(
        1.0,
        0.2 + floor(damage_gradient) * 0.03,
        true);
		
	var tc_bloodred = merge_color(c_red, c_maroon, 0.6);
	var tc_bloodgold = make_color_rgb(239, 172, 40);
		
	repeat (max(2.0, (stats.m_healthPrev - stats.m_health) * 0.2))
	{
		var blud = new(o_ptcBloodHud);
			blud.m_damageType = m_lastDamage;
			// Set up colors
			blud.image_blend = tc_bloodred;
		// Make it gold when really hurt
		if (stats.m_health < stats.m_healthMax * 0.5) {
			if (random(1.0) > stats.m_health / stats.m_healthMax) {
				blud.image_blend = tc_bloodgold;
			}
		}
		with (blud) event_user(0); // Init the blood
	}
	// On Hurt for hud-blood
	with (o_ptcBloodHud) event_user(1);
}

event_inherited();

