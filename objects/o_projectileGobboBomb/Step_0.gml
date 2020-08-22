/// @description Motion & Collision & SPEEN
event_inherited();

// Update on-ground check
if (z_height > 0)
{
	m_onGround = false;
}
else
{
	if (!m_onGround)
	{
		effectOnGroundHit(x, y);
	}
	m_onGround = true;
}

if (m_moving)
{
	zspeed -= zgravity * Time.deltaTime;
	if (m_onGround)
	{
		effectOnGroundStep(x, y, point_direction(0, 0, xspeed, yspeed));
	}
}
else
{
	/*var item = instance_create_depth(x, y, depth - 1, m_itemObject);
		item.z = z;
		item.z_height = z_height;
		
	idelete(this);*/
}

// Run down fuse timer. Explode at the end
m_fuseTimer -= Time.deltaTime;
if (m_fuseTimer < 0.0)
{
	var effect = instance_create_depth(x, y, depth - 100, o_fxExplosionGobboBomb);
		effect.z = z;
		
	// Shake screen
	if (point_on_camera_wide(x, y, 64, 64))
	{
		effectScreenShake(3, 1.5, true);
	}
		
	// Deal damage
	var kDamageRadius = 70;
	var kDamage = 10;
	var t_hitList = ds_list_create();
	var t_hitCount = collision_circle_list(x, y, kDamageRadius, ob_character, false, true, t_hitList, false);
	
	for (var i = 0; i < t_hitCount; ++i)
	{
		var t_currentTarget = t_hitList[|i];
		var t_hitResult = damageGetHitResult(iexists(m_owner) ? m_owner : id, t_currentTarget);
		
		if (t_hitResult != kDamageResultMissEthereal
			&& t_hitResult != kDamageResultMissDodge)
		{
			var t_falloff = point_distance(x, y, t_currentTarget.x, t_currentTarget.y) / kDamageRadius;
			//var t_linearFalloff = saturate(1.0 - (t_falloff - 0.1) / 0.9);
			var t_sqrFalloff = saturate(1.0 - sqr((t_falloff - 0.1) / 0.9));
			
			// Deal damage with sqr falloff.
			damageTargetForced(t_currentTarget, kDamage * t_sqrFalloff, kDamageTypeFire, true, true);
	
			// Deal a stun with sqr falloff.
			t_currentTarget.stats.m_stun += max(0.0, 6.0 * t_sqrFalloff);
	
			// If stun is lower than a certain amount, kick the NPC into stun mode.
			// (This is handled already)
		}
	}
	
	ds_list_destroy(t_hitList);
	
	idelete(this);
}
