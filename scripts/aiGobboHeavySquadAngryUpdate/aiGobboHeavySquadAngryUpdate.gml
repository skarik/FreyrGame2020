#region Follows Commands, but with mostly passthru.

if (m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_Hover)
{
	/*var dist_sqr = sqr(x - m_aiGobbo_squadStateTargetPosition[0]) + sqr(y - m_aiGobbo_squadStateTargetPosition[1]);
	if (dist_sqr > 4)
	{
		aipathMoveTo(m_aiGobbo_squadStateTargetPosition[0], m_aiGobbo_squadStateTargetPosition[1]);
	}
	else
	{
		_controlStructUpdate(xAxis, 0.0);
		_controlStructUpdate(yAxis, 0.0);
	}
	aimotionFaceAt(m_aiCombat_targetPosition[0], m_aiCombat_targetPosition[1], -1);*/
	
	// Stop any signalling when walking
	moAnimationExternal = false;
}
else if (m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_Hesitate)
{
	/*_controlStructUpdate(xAxis, 0.0);
	_controlStructUpdate(yAxis, 0.0);
	_controlStructUpdate(atkButton, 0.0);*/
}
// Perform attack
else if (m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_AttackToHesitate
		|| m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_AttackToHover)
{
	if (m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_AttackToHesitate)
	{
		m_aiGobbo_squadStateCase = kAiGobboSquadStateCase_Hesitate;
	}
	else if (m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_AttackToHover)
	{
		m_aiGobbo_squadStateCase = kAiGobboSquadStateCase_Hover;
	}
}

#endregion

#region High level AI

if (m_aiGobboHeavy_state == kAiGobboHeavyState_NotAngry)
{
	// Not angry, but we're here. It's time to begin the fight properly.
	if (array_length_1d(m_colliders) == 0)
	{
		m_aiGobboHeavy_state = kAiGobboHeavyState_BeginFight;
		m_aiGobboHeavy_statetimer = 0.0;
	}
	else
	{
		// Skip to the fight if the stones already are placed down
		m_aiGobboHeavy_state = kAiGobboHeavyState_Fight0;
		m_aiGobboHeavy_statetimer = 0.0;
	}
}
else if (m_aiGobboHeavy_state == kAiGobboHeavyState_BeginFight)
{
	// If timer is at 0, then we begin the animation that starts the fight
	if (m_aiGobboHeavy_statetimer <= 0.0)
	{
		moScriptOverride = _characterGobboHeavyMoBeginFight0;
		m_aiGobboHeavy_movetimer = 0.0; // Reset its timer
		m_aiGobboHeavy_statetimer = 1.0; // Out of first substate
	}
	else if (moScriptOverride != _characterGobboHeavyMoBeginFight0)
	{
		// Move to the other ai state
		m_aiGobboHeavy_state = kAiGobboHeavyState_Fight0;
	}
}
else if (m_aiGobboHeavy_state == kAiGobboHeavyState_Fight0)
{
	// Do FIGHT!
	
	// We have three attacks:
	// 1) Melee 
	// 2) Ranged percing line
	// 3) Ranged blocked scatter

	var deltaFromTarget = avec2_subtract([x, y], m_aiCombat_targetPosition);
	var distanceToTarget = avec2_length(deltaFromTarget);
	var directionToTarget = avec2_divide(deltaFromTarget, distanceToTarget);
	var targetPosition = avec2_add(m_aiCombat_targetPosition, avec2_multiply(directionToTarget, clamp(distanceToTarget, 16, 40)));
	aimotionMoveTo(targetPosition[0], targetPosition[1], 1.0);
	if (distanceToTarget > 16 && distanceToTarget < 40)
	{
		if (!isAttacking)
		{
			aimotionFaceAt(m_aiCombat_targetPosition[0], m_aiCombat_targetPosition[1], 720);
		}
	}
	
	// Do attacks on a timer, different timer if in melee range
	if (moScriptOverride == null)
	{
		if (distanceToTarget < 40)
		{
			moScriptOverride = _characterGobboHeavyMoMelee0;
			m_aiGobboHeavy_movetimer = 0.0; // Reset its timer
		}
	}
	
	// If player is attacking, possible dodge
	if (moScriptOverride == _characterGobboHeavyMoMelee0)
	{
		if (iexists(m_aiCombat_target)
			&& m_aiCombat_target.isAttacking
			&& stats.m_stun > stats.m_stunMax * 0.7)
		{
			// Request a dodge backwards at this point
			meleeDashQueued = true;
		}
	}
	
}

#endregion