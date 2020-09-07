function aiGobboMageSquadAngryUpdate() {
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

#region Hover nearby nearest angry guy, trying to hide behind it

	m_aiGobbo_angrystateTimer += Time.deltaTime;
	if (m_aiGobbo_angrystateTimer > 1.0)
	{
		m_aiGobbo_angrystateTimer = min(1.0, m_aiGobbo_angrystateTimer - 1.0); // Reset the timer
	
		if (!iexists(m_aiGobbo_angrystateTarget) || random(1.0) < 0.5)
		{
			m_aiGobbo_angrystateTarget = null;
		
			var t_callee = id;
			var t_callee_x = x;
			var t_callee_y = y;
			var t_nearestGobbos = ds_priority_create();
			with (m_aiGobbo_baseObject)
			{
				if (id != t_callee
					&& m_aiCombat_target == t_callee.m_aiCombat_target)
				{
					ds_priority_add(t_nearestGobbos, id, sqr(x - t_callee_x) + sqr(y - t_callee_y));
				}
			}
			var t_possibleNearest = ds_priority_delete_min(t_nearestGobbos);
			ds_priority_destroy(t_nearestGobbos);
		
			m_aiGobbo_angrystateTarget = t_possibleNearest;
		}
	
		// Find a position behind the hiding target
		if (iexists(m_aiGobbo_angrystateTarget) && iexists(m_aiCombat_target))
		{
			var delta = [m_aiGobbo_angrystateTarget.x - m_aiCombat_target.x, m_aiGobbo_angrystateTarget.y - m_aiCombat_target.y];
			var delta_len = avec2_length(delta);
		
			m_aiGobbo_angrystatePosition = [m_aiGobbo_angrystateTarget.x + delta[0] / delta_len * 40,
											m_aiGobbo_angrystateTarget.y + delta[1] / delta_len * 40];
		}
		else
		{
			m_aiGobbo_angrystatePosition = [m_aiGobbo_squadStateTargetPosition[0], m_aiGobbo_squadStateTargetPosition[1]];
		}
	}

	m_aiGobbo_angrystateActionTimer += Time.deltaTime;
	if (m_aiGobbo_angrystateCurrent == 0)
	{
		// Move to that position
		aipathMoveTo(m_aiGobbo_angrystatePosition[0], m_aiGobbo_angrystatePosition[1]);
	
		// After 3 seconds, check if should do a heal
		if (m_aiGobbo_angrystateActionTimer > 3.0)
		{
			// something's hurt?
			if ((iexists(m_aiGobbo_angrystateTarget) && m_aiGobbo_angrystateTarget.stats.m_health < m_aiGobbo_angrystateTarget.stats.m_healthMax * 0.8)
				|| stats.m_health < stats.m_healthMax * 0.8)
			{
				// Set up the spell
				moScriptOverride = magicMove0Script;
				isAttacking = true;
				isDashing = false;
				meleeAtkTimer = 0.0;
				meleeAtkCurrent = 0;
			
				// Go to waiting for spell to end
				m_aiGobbo_angrystateCurrent = 1;
			}
			else
			{
				m_aiGobbo_angrystateActionTimer = 0.0;
			}
		}
	}
	else if (m_aiGobbo_angrystateCurrent == 1)
	{
		// Run the heal
	
		// When it's done healing, leave
		if (moScriptOverride != magicMove0Script)
		{
			// Go back to moving
			m_aiGobbo_angrystateCurrent = 0;
			m_aiGobbo_angrystateActionTimer = random_range(-1.0, 0.0);
		}
	}


#endregion


}
