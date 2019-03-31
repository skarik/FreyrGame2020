//@function  damageTarget(target, damage, damageType, hitEffect, hitShake)
//@description Apply damage to the target. Source is the callee.
//@param target Target we're damaging
//@param damage Amount of damage
//@param damageType Type of the damage
//@param source Source of the target
//@param hitEffect should particles and sound be emitted
//@param hitShake should screen shake for the damage

var target = argument0;
var damage = argument1;
var damageType = argument2;
var source = id;
var hitEffect = argument3;
var hitShake = argument4;

// Check if can hit first
if (!damageCanHit(target, source))
	return;

// Generate intersecting BB for the effect spawning
var c_x1 = target.x-target.sprite_xoffset;
var c_y1 = target.y-target.sprite_yoffset;
var c_x2 = target.x-target.sprite_xoffset+target.sprite_width;
var c_y2 = target.y-target.sprite_yoffset+target.sprite_height;

if (hitEffect)
{
    // Create hit sound
    var sound_hit = sound_play_at(random_range(c_x1,c_x2), random_range(c_y1,c_y2), effectGetImpactSound(target.m_bloodType));
    
    // Create hit effect
    var fx_hit = instance_create_depth(random_range(c_x1,c_x2), random_range(c_y1,c_y2), target.depth - 5, effectGetImpactEffect(target.m_bloodType));
}

// Select the team
var damageTeam = kTeamNone;
if (exists(source)) {
	damageTeam = source.m_team;
}

with (target)
{
	if (damageCanHit(source, id) == false)
		continue; // Skip things we can't hurt
		
	// Modify the damage
	var actualDamage = damageApplyModifiers(target, damage, damageType);
	
	// Perform damage
	stats.m_health -= actualDamage;
	
	// Create damage ticker
	var ticker = instance_create_depth(random_range(c_x1,c_x2), random_range(c_y1,c_y2), depth - 5, o_floaterDmgTicker);
		ticker.value = actualDamage;
	
	// Create knockback
	/*if (source.m_isPlayer)
	{
	    // Mark as stunned
	    isStunned = true;
	    stunTimer = max(0, stunTimer) + (min(damage,50) * 0.015);
	    // Add knockback
	    var kickback = damage * 8;
	    if ( abs(xspeed) < kickback || sign(xspeed) != sign(x - source.x) )
	        xspeed = sign(x - source.x) * kickback * 0.5;
	    // Push in the air for effect
	    yspeed = -40;
	}*/
}

if (hitShake && source.m_isPlayer)
{           
    // Shake the screen for effect
    effectScreenShake( 3, 0.15, true );
    effectControllerShake( 1.0, 0.1, true );
}


