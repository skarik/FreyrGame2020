event_inherited();

// animation update
//playerAnimLateUpdate();

// usable & combat update
playerInteractEndStep();

// update area
var next_area = areaFromRoom(room);
if (canMove
	&& next_area != kAreaNoArea && next_area != m_currentArea
	&& !ctsGabbersHaveFocus()
	&& !iexists(o_uiNewArea)
	&& !iexists(o_cts00_2_InitialWalkPast))
{
	m_currentAreaTimer += min(0.1, Time.deltaTime);
	if (m_currentAreaTimer > 1.0)
	{
		m_currentArea = next_area;
		
		var notifier = inew(o_uiNewArea);
			notifier.m_area = m_currentArea;
			
		debugOut("New area: " + areaGetName(next_area));
	}
}
else
{
	m_currentAreaTimer = 0.0;
}

// Balancing items on the head
{
	// update balance pivot
	var t_balance_delta = [m_itemBalancePivot[0] - x, m_itemBalancePivot[1] - y];

	// Do acceleration
	m_itemBalanceSpeed[0] = motion1d_to(m_itemBalanceSpeed[0], xspeed - t_balance_delta[0] * 2, 200 * Time.deltaTime);
	m_itemBalanceSpeed[1] = motion1d_to(m_itemBalanceSpeed[1], yspeed - t_balance_delta[1] * 2, 200 * Time.deltaTime);
	// Do drag
	var t_balanceSpeed = avec2_sqrlength(m_itemBalanceSpeed);
	if (t_balanceSpeed > 0.0)
	{
		t_balanceSpeed = sqrt(t_balanceSpeed);
		var t_newBalanceSpeed = motion1d_to(t_balanceSpeed, 0.0, t_balanceSpeed * 2.0 * Time.deltaTime);
		var t_balanceSpeedMultiplier = t_newBalanceSpeed / t_balanceSpeed;
		m_itemBalanceSpeed = avec2_multiply(m_itemBalanceSpeed, t_balanceSpeedMultiplier);
	}
	
	// Do motion
	m_itemBalancePivot[0] += m_itemBalanceSpeed[0] * Time.deltaTime;
	m_itemBalancePivot[1] += m_itemBalanceSpeed[1] * Time.deltaTime;

	// Recalculate limits
	t_balance_delta = [m_itemBalancePivot[0] - x, m_itemBalancePivot[1] - y];
	var t_balance_len = avec2_length(t_balance_delta);
	var tkMaxBalancePivotDistance = 10;
	// Limit distance
	if (t_balance_len > tkMaxBalancePivotDistance)
	{
		m_itemBalancePivot[0] = x + (t_balance_delta[0] / t_balance_len) * tkMaxBalancePivotDistance;
		m_itemBalancePivot[1] = y + (t_balance_delta[1] / t_balance_len) * tkMaxBalancePivotDistance;
	}
	
	m_itemBalanceSpringTimestep += Time.deltaTime * 100.0;
	while (m_itemBalanceSpringTimestep > 1.0)
	{
		m_itemBalanceSpringTimestep -= 1.0;
		var kTimestep = 1.0 / 100.0;
		
		// Now do spring motion going to the target t_balance_delta
		t_balance_delta = [m_itemBalancePivot[0] - x, m_itemBalancePivot[1] - y]; // This is the target for the spring
	
		// Get current velocity from the delta from previous position
		var t_springVelocity = avec2_subtract(m_itemBalanceSpringOffset, m_itemBalanceSpringOffsetPrevious);
		t_springVelocity = avec2_divide(t_springVelocity, kTimestep);
		
		// Save next previous now that we're done with it.
		m_itemBalanceSpringOffsetPrevious[0] = m_itemBalanceSpringOffset[0];
		m_itemBalanceSpringOffsetPrevious[1] = m_itemBalanceSpringOffset[1];
		
		// Accelerate towards the target
		var t_springTargetDelta = avec2_subtract(t_balance_delta, m_itemBalanceSpringOffset);
		t_springVelocity = avec2_add(t_springVelocity, avec2_multiply(t_springTargetDelta, kTimestep * 35.0));
		
		// Add drag
		var t_springSpeed = avec2_length(t_springVelocity);
		if (t_springSpeed > 0.0)
		{
			var t_newSpringSpeed = motion1d_to(t_springSpeed, 0.0, t_springSpeed * 6.0 * kTimestep);
			var t_springSpeedMultiplier = t_newSpringSpeed / t_springSpeed;
			t_springVelocity = avec2_multiply(t_springVelocity, t_springSpeedMultiplier);
		}
		
		// Apply the motion
		m_itemBalanceSpringOffset = avec2_add(m_itemBalanceSpringOffset, avec2_multiply(t_springVelocity, kTimestep));
	}
}
