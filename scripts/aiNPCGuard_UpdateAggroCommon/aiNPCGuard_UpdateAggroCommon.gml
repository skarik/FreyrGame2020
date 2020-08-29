///@function aiNPCGuard_UpdateAggroCommon()
var t_nextTarget = null;
{
	// Update AI target
	var t_possibleTargetList = array_create(0);
	
	t_possibleTargetList[0] = getPlayer();
	
	if (object_index != o_chMithraGaurdNpc)
	{
		// Add other possible targets
		with (ob_character)
		{
			if (m_team != kTeamNone && (m_team & other.m_team) == 0)
			{
				t_possibleTargetList[array_length_1d(t_possibleTargetList)] = id;
			}
		}
	}
	
	
	// check visibility with each target
	t_nextTarget = m_aiCombat_target;
	for (var i = 0; i < array_length_1d(t_possibleTargetList); ++i)
	{
		var t_possibleTarget = t_possibleTargetList[i];
		if (iexists(t_possibleTarget)
			&& !t_possibleTarget.isHidden
			&& !t_possibleTarget.m_isDead && !t_possibleTarget.m_isKOed
			&& !aiPointInSafeArea(t_possibleTarget.x, t_possibleTarget.y)
			&& ((m_aiNPC_fastAggro && t_possibleTarget.m_isPlayer)
			|| aicommonCanSee(t_possibleTarget.x, t_possibleTarget.y, t_possibleTarget.z,
								facingDirection, m_aiCombat_noticeDistance,
								(m_aiCombat_angry && t_possibleTarget == m_aiCombat_target) ? 360 : m_aiCombat_noticeAngle,
								true)))
		{
			t_nextTarget = t_possibleTarget; // we have a new best target yay
		}
	}
	
	var bFastAggro = false;
	if (m_aiNPC_fastAggro)
	{
		// Check if target is in the current aggro area
		aiGAlertUpdateCurrent();
		if (iexists(m_aialert_area))
		{
			var callee = id;
			with (m_aiCombat_target)
			{
				if (position_meeting(x, y, callee.m_aialert_area))
				{
					bFastAggro = true;
					break;
				}
			}
		}
		else
		{
			var callee = id;
			with (m_aiCombat_target)
			{
				if (point_distance(x, y, callee.x, callee.y) < 200)
				{
					bFastAggro = true;
					break;
				}
			}
		}
	}
	
	var bInSafeArea = aiPointInSafeArea(m_aiCombat_target.x, m_aiCombat_target.y);
	
	// Check if can see the target
	if (iexists(m_aiCombat_target)
		&& !m_aiCombat_target.isHidden
		&& !m_aiCombat_target.m_isDead && !m_aiCombat_target.m_isKOed
		&& !bInSafeArea
		&& (bFastAggro 
		|| aicommonCanSee(m_aiCombat_target.x, m_aiCombat_target.y, m_aiCombat_target.z,
							facingDirection, m_aiCombat_noticeDistance,
							m_aiCombat_angry ? 360 : m_aiCombat_noticeAngle,
							true)))
	{
		m_aiCombat_targetVisible = true;
		m_aiCombat_targetPosition = [m_aiCombat_target.x, m_aiCombat_target.y];
		m_aiCombat_targetTrackingLossTime = 0.0;
	}
	// If we cannot see the target, we want to stop tracking
	else if (iexists(m_aiCombat_target)
		&& !m_aiCombat_target.m_isDead && !m_aiCombat_target.m_isKOed)
	{
		m_aiCombat_targetVisible = false;
		m_aiCombat_targetTrackingLossTime += Time.deltaTime;
		
		if (m_aiCombat_targetTrackingLossTime > 1.0 // Lost tracking for 1 second
			// Force fast deaggro when in a safe area
			|| bInSafeArea)
		{			
			// Lost target, look for new target.
			if (m_aiCombat_target != t_nextTarget
				&& (iexists(t_nextTarget)
					|| m_aiCombat_targetTrackingLossTime > 3.0
					// Force fast deaggro when in a safe area
					|| bInSafeArea
					)
				)
			{	// Switch anger target
				m_aiCombat_target = t_nextTarget;
				m_aiCombat_aggroTimer = 0.0; // Refresh aggro.
			}
		}
	}
	// If is dead, immediately stop tracking
	else
	{
		m_aiCombat_targetVisible = false;
		m_aiCombat_targetTrackingLossTime = max(1.0, m_aiCombat_targetTrackingLossTime + Time.deltaTime);
		
		// Look for new target if it exists.
		if (m_aiCombat_target != t_nextTarget && (iexists(t_nextTarget)))
		{	// Switch anger target
			m_aiCombat_target = t_nextTarget;
			m_aiCombat_aggroTimer = 0.0; // Refresh aggro.
		}
	}
} // End aggro update