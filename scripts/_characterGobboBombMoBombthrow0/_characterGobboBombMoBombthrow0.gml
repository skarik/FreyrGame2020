function _characterGobboBombMoBombthrow0() {
	// Increment timer
	var l_meleeAtkTimerPrev = meleeAtkTimer;
	meleeAtkTimer += Time.deltaTime;

	// Force attack state on
	//isAttacking = true;

	// Do checks & motion
	_playerMoCommonAttackPreMove(0.0, false);

	// If starting out, begin the particle system
	if (l_meleeAtkTimerPrev < 0.0 && meleeAtkTimer >= 0.0)
	{
		//magicMoveTarget = null;
	}
	// If passing the key point, do the heal effect
	if (l_meleeAtkTimerPrev < magicMove0PreCast && meleeAtkTimer >= magicMove0PreCast)
	{
		// Choose a thing to heal at this point
		/*magicMoveTarget = id;
	
		// Heal the dude we're hiding behind if his HP is lower
		if (iexists(m_aiGobbo_angrystateTarget) && !m_aiGobbo_angrystateTarget.m_isDead
			&& (stats.m_health / stats.m_healthMax) > 0.4
			&& (m_aiGobbo_angrystateTarget.stats.m_health / m_aiGobbo_angrystateTarget.stats.m_healthMax) < (stats.m_health / stats.m_healthMax))
		{
			magicMoveTarget = m_aiGobbo_angrystateTarget;
		}*/
	
		// Create the effect
		var effect = instance_create_depth(x, y, depth - 100, o_ptcCircleHit_Outline);
			effect.image_blend = c_white;
			effect.fadeSpeed = 10;
	}
	// if passing the hit point, do the damage
	if (l_meleeAtkTimerPrev < magicMove0Hit && meleeAtkTimer >= magicMove0Hit)
	{
		// do heal at the hit point
		/*if (iexists(magicMoveTarget))
		{		
			magicMoveTarget.m_isKOed = false;
			magicMoveTarget.moScriptOverride = null;
			magicMoveTarget.stats.m_health = max(16, magicMoveTarget.stats.m_health + 16);
			magicMoveTarget.stats.m_stun += 2;
			magicMoveTarget.m_isStunned = false;
		
			// Create the effect
			var effect = instance_create_depth(magicMoveTarget.x, magicMoveTarget.y, magicMoveTarget.depth - 100, o_ptcCircleHit_Outline);
				effect.image_blend = c_crystalblue;
		}*/
	
		// Throw at m_aiCombat_targetPosition
		var t_delta = [m_aiCombat_targetPosition[0] - x, m_aiCombat_targetPosition[1] - y];
		var t_deltaLength = avec2_length(t_delta);
	
		var t_travelTime = clamp((t_deltaLength - 50) / 250, 1.0, 2.0);
		var t_gravity = 240;
		var t_zheight = 24;
		var t_ztarget = 0;
	
		//var t_zspeed = t_gravity * t_travelTime / 2.0;
		var t_zspeed = (t_gravity * sqr(t_travelTime) * 0.5 - t_zheight + t_ztarget) / t_travelTime;
		var t_xyspeed = t_deltaLength / t_travelTime;
	
		//var t_zspeed = clamp(t_deltaLength 
		var projectile = instance_create_depth(x, y, depth - 2, o_projectileGobboBomb);
			projectile.z = z;
			projectile.z_height = t_zheight;
			projectile.m_owner = id;
			projectile.m_team = m_team;
			projectile.xspeed = t_delta[0] / t_deltaLength * t_xyspeed;
			projectile.yspeed = t_delta[1] / t_deltaLength * t_xyspeed;
			projectile.zspeed = t_zspeed;
			projectile.zgravity = t_gravity;
	}

	// if past the length, or stunned, end the spell
	if (meleeAtkTimer > magicMove0Time || m_isStunned)
	{
		meleeDashQueued = false;
		meleeAtkQueued = false;
		meleeAtkTimer = 0.0;
		if (moScriptOverride == _characterGobboBombMoBombthrow0)
		{
			moScriptOverride = null;
			isAttacking = false;
		}
		else
		{
			isAttacking = false;
		}
	}

	// update animation
	sprite_index = kAnimAttack1;
	animationIndex = floor((image_number / 4.0 - 0.01) * saturate(meleeAtkTimer / magicMove0Time));


}
