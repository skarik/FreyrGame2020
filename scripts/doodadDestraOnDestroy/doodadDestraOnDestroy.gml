function doodadDestraOnDestroy() {
	repeat (3)
	{
		var poof = instance_create_depth(x, y - 4, depth - 1, o_ptcDustPoof);
		poof.m_direction = random(360);
		poof.m_xspeed = lengthdir_x(random_range(10.0, 40.0), poof.m_direction);
		poof.m_yspeed = lengthdir_y(random_range(10.0, 40.0), poof.m_direction);
		poof.m_friction = 80.0;
		poof.m_life = 0.9;
		poof.m_size = 13.0;
		poof.image_blend = c_ltgray;
	
		// Sound for the hit
		// TODO: different sounds for different sprites
		var audio = sound_play_at(x, y, "audio/phys/key_break0.wav");
		audio.pitch = random_range(1.1, 1.2);
		audio.gain = 0.8 / max(1.0, audio.pitch);
		audio.falloff_start = 20;
		audio.falloff_end = 800;
		audio.falloff_factor = 2;
	}

	if (sprite_index == s_propDesertBarrelSmol1
		|| sprite_index == s_propDesertBarrelMeed1)
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
	
		// Damage characters in range:
		var t_hitCount = collision_circle_list(x, y, kDamageRadius, ob_character, false, true, t_hitList, false);
		for (var i = 0; i < t_hitCount; ++i)
		{
			var t_currentTarget = t_hitList[|i];
			var t_hitResult = damageGetHitResult(id, t_currentTarget);
		
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
		ds_list_clear(t_hitList);
		// Damage breakables in range:
		var t_hitCount = collision_circle_list(x, y, kDamageRadius, ob_doodadBreakable, false, true, t_hitList, false);
		for (var i = 0; i < t_hitCount; ++i)
		{
			var t_currentTarget = t_hitList[|i];
		
			var t_falloff = point_distance(x, y, t_currentTarget.x, t_currentTarget.y) / kDamageRadius;
			//var t_linearFalloff = saturate(1.0 - (t_falloff - 0.1) / 0.9);
			var t_sqrFalloff = saturate(1.0 - sqr((t_falloff - 0.1) / 0.9));
			
			// Deal damage with sqr falloff.
			damageTargetBreakable(t_currentTarget, kDamage * t_sqrFalloff, kDamageTypeFire, true, true);
		}
	
		ds_list_destroy(t_hitList);
	}


}
