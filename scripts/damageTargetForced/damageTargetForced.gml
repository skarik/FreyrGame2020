/// @function  damageTargetForced(target, damage, damageType, hitEffect, hitShake)
/// @description Apply damage to the target. Source is the callee.
/// @param target Target we're damaging
/// @param damage Amount of damage
/// @param damageType Type of the damage
/// @param hitEffect should particles and sound be emitted
/// @param hitShake should screen shake for the damage
function damageTargetForced(argument0, argument1, argument2, argument3, argument4) {

	var target = argument0;
	var damage = argument1;
	var type = argument2;
	var source = id;
	var hitEffect = argument3;
	var hitShake = argument4;

	// Check if can hit first
	//if (!damageCanHit(target, source))
	//	return;

	// Save dealt damage
	m_dealtDamage = true;
	m_dealtDamageList[array_length_1d(m_dealtDamage)] = target;

	// Generate intersecting BB for the effect spawning
	var c_x1 = target.x-target.sprite_xoffset;
	var c_y1 = target.y-target.sprite_yoffset;
	var c_x2 = target.x-target.sprite_xoffset+target.sprite_width;
	var c_y2 = target.y-target.sprite_yoffset+target.sprite_height;

	/*if (hitEffect)
	{
	    // Create hit sound
	    //var sound_hit = sound_play_at(random_range(c_x1,c_x2), random_range(c_y1,c_y2), effectGetImpactSound(target.m_bloodType, damageType, id));
    
	    // Create hit effect
	    //var fx_hit = instance_create_depth(random_range(c_x1,c_x2), random_range(c_y1,c_y2), target.depth - 5, effectGetImpactEffect(target.m_bloodType, damageType, id));
	
		with (target)
		{
			// Create hit sound
			var sound_hit = sound_play_at(random_range(c_x1,c_x2), random_range(c_y1,c_y2), effectGetImpactSound(m_bloodType, type, source));
        
			// Create hit effect
			var fx_hit = instance_create_depth(random_range(c_x1,c_x2), random_range(c_y1,c_y2), depth - 5, effectGetImpactEffect(m_bloodType, type, source));
				fx_hit.m_source = id;
				fx_hit.m_health = stats.m_health;
				fx_hit.m_healthMax = stats.m_healthMax;
				fx_hit.m_damage = actualDamage;
		}
	}*/

	// Select the team
	var damageTeam = kTeamNone;
	if (iexists(source)) {
		damageTeam = source.m_team;
	}

	with (target)
	{
		//if (damageCanHit(source, id) == false)
		//	continue; // Skip things we can't hurt
		
		// Modify the damage
		var actualDamage = damageApplyModifiers(target, damage, type);
	
		// Perform damage
		stats.m_health -= actualDamage;
	
		// Save damage
		m_lastDamage = type;
		m_lastDamageSource = source;
	
		// Create damage ticker
		var ticker = instance_create_depth(random_range(c_x1,c_x2), random_range(c_y1,c_y2), depth - 5, o_floaterDmgTicker);
			ticker.value = actualDamage;
	
		if (hitEffect)
		{
			// Create hit sound
			var sound_hit = sound_play_at(random_range(c_x1,c_x2), random_range(c_y1,c_y2), effectGetImpactSound(m_bloodType, type, source));
        
			// Create hit effect
			var fx_hit = instance_create_depth(random_range(c_x1,c_x2), random_range(c_y1,c_y2), depth - 5, effectGetImpactEffect(m_bloodType, type, source));
				fx_hit.m_source = id;
				fx_hit.m_health = stats.m_health;
				fx_hit.m_healthMax = stats.m_healthMax;
				fx_hit.m_damage = actualDamage;
		}
	
		// Mark as stunned
	    //m_isStunned = true;
	    //m_stunTimer = max(0, m_stunTimer) + (min(damage, 50) * 0.025) * 2.0;
		if (!m_isStunned)
			stats.m_stun += 1.0;
	    // Add knockback
	    var kickback = damage * 16 * kKickbackAmount;
	    /*if ( abs(xspeed) < kickback || sign(xspeed) != sign(x - source.x) )
	        xspeed = sign(x - source.x) * kickback * 0.5;
	    // Push in the air for effect
	    yspeed = -80;*/
		var tspeed = sqrt(sqr(xspeed) + sqr(yspeed));
		if (tspeed < kickback)
		{
			var tdirection = point_direction(source.x, source.y, x, y);
			xspeed += lengthdir_x(kickback, tdirection);
			yspeed += lengthdir_y(kickback, tdirection);
			// Push in the air for effect
			zspeed += kickback;
			if (zspeed > 0)
			{
				onGround = false;
			}
		}
	}

	if (hitShake && source.m_isPlayer)
	{           
	    // Shake the screen for effect
	    effectScreenShake( 3, 0.15, true );
	    effectControllerShake( 1.0, 0.1, true );
	}





}
