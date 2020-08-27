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
}

#endregion