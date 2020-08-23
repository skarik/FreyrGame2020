/// @function  damageTarget(target, damage, damageType, hitEffect, hitShake)
/// @description Apply damage to the target. Source is the callee.
/// @param target Target we're damaging
/// @param damage Amount of damage
/// @param damageType Type of the damage
/// @param hitEffect should particles and sound be emitted
/// @param hitShake should screen shake for the damage

var target = argument0;
var damage = argument1;
var type = argument2;
var source = id;
var hitEffect = argument3;
var hitShake = argument4;

// Generate intersecting BB for the effect spawning
var c_x1 = target.x-target.sprite_xoffset;
var c_y1 = target.y-target.sprite_yoffset;
var c_x2 = target.x-target.sprite_xoffset+target.sprite_width;
var c_y2 = target.y-target.sprite_yoffset+target.sprite_height;

with (target)
{
	// Modify damage based on armor
	var actualDamage = damageApplyModifiers(id, damage, type);
		
	// Perform damage
    m_health -= actualDamage;
        
    // Create damage ticker
    var ticker = instance_create_depth(random_range(c_x1,c_x2), random_range(c_y1,c_y2), depth - 5, o_floaterDmgTicker);
        ticker.value = actualDamage;
        
    // Create hit sound
    //var sound_hit = sound_play_at(random_range(c_x1,c_x2), random_range(c_y1,c_y2), effectGetImpactSound(m_bloodType));
        
    // Create hit effect
    //var fx_hit = instance_create_depth(random_range(c_x1,c_x2), random_range(c_y1,c_y2), depth - 5, effectGetImpactEffect(m_bloodType));
    // Perform normal OnHit
	doodadDestraOnHit(source, c_x1, c_y1, c_x2, c_y2);
		
    // Create knockback
    if (source.m_isPlayer)
    {
        // Shake the screen for effect
		effectScreenShake( 3, 0.15, true );
		effectControllerShake( 1.0, 0.1, true );
    }
}
