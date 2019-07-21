/// @function  Combat_Hitbox(source,x1,y1,x2,y2,damage,type)
/// @param source
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param damage
/// @param type
var source = argument0;
var x1 = argument1; var y1 = argument2;
var x2 = argument3; var y2 = argument4;
var damage = argument5;
var type = argument6;

// For debug purposes, draw the bounding box of the hitbox
if (Debug.on)
{
	debugBox(x1, y1, x2, y2, c_gray);
}

// Perform the collision against both enemies and destroyable blox
with (ob_doodadBreakable)
{
    if (id != source && collision_rectangle(x1,y1,x2,y2, id, true, false) != null)
    {
        // Modify damage based on armor
		var actualDamage = damageApplyModifiers(id, damage, type);
		
		// Perform damage
        m_health -= actualDamage;
        
        // Generate intersecting BB for the effect spawning
        var c_x1 = max( x1, x-sprite_xoffset );
        var c_y1 = max( y1, y-sprite_yoffset );
        var c_x2 = min( x2, x-sprite_xoffset+sprite_width );
        var c_y2 = min( y2, y-sprite_yoffset+sprite_height );
        
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
}
with (ob_character)
{
    if (id != source && ((m_team & source.m_team) == 0) && collision_rectangle(x1,y1,x2,y2, id, true, false) != null)
    {
		// Modify damage based on armor
		var actualDamage = damageApplyModifiers(id, damage, type);
		
		// Perform damage
        stats.m_health -= actualDamage;
        
		// Save damage
		m_lastDamage = type;
		
        // Generate intersecting BB for the effect spawning
        var c_x1 = max( x1, x-sprite_xoffset );
        var c_y1 = max( y1, y-sprite_yoffset );
        var c_x2 = min( x2, x-sprite_xoffset+sprite_width );
        var c_y2 = min( y2, y-sprite_yoffset+sprite_height );
        
        // Create damage ticker
        var ticker = instance_create_depth(random_range(c_x1,c_x2), random_range(c_y1,c_y2), depth - 5, o_floaterDmgTicker);
            ticker.value = actualDamage;
        
        // Create hit sound
        var sound_hit = sound_play_at(random_range(c_x1,c_x2), random_range(c_y1,c_y2), effectGetImpactSound(m_bloodType, type, source));
        
        // Create hit effect
        var fx_hit = instance_create_depth(random_range(c_x1,c_x2), random_range(c_y1,c_y2), depth - 5, effectGetImpactEffect(m_bloodType, type, source));
			fx_hit.m_source = id;
			fx_hit.m_health = stats.m_health;
			fx_hit.m_healthMax = stats.m_healthMax;
			fx_hit.m_damage = actualDamage;
        
        // Mark as stunned
        m_isStunned = true;
        m_stunTimer = max(0, m_stunTimer) + (min(damage, 50) * 0.025) * 2.0;
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
        
        // Create knockback
        if (source.m_isPlayer)
        {   
            // Set on fire
            /*if ( isGooed )
            {
                if ( !isBurning )
                {
                    isBurning = true;
                    // Play sound
                    sound_play_at(x,y,sndFireStart);
                }
                else
                {
                    fiTimer = 0; // Refresh the burn timer
                }
            }*/
        }
        
        if (source.m_isPlayer)
        {           
            // Shake the screen for effect
			effectScreenShake( 3, 0.15, true );
			effectControllerShake( 1.0, 0.1, true );
        }
    }
}

