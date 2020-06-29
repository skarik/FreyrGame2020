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

	// Do motion
	m_itemBalanceSpeed[0] = motion1d_to(m_itemBalanceSpeed[0], xspeed - t_balance_delta[0] * 2, 200 * Time.deltaTime);
	m_itemBalanceSpeed[1] = motion1d_to(m_itemBalanceSpeed[1], yspeed - t_balance_delta[1] * 2, 200 * Time.deltaTime);
	m_itemBalancePivot[0] += m_itemBalanceSpeed[0] * Time.deltaTime;
	m_itemBalancePivot[1] += m_itemBalanceSpeed[1] * Time.deltaTime;

	// Recalculate limits
	t_balance_delta = [m_itemBalancePivot[0] - x, m_itemBalancePivot[1] - y];
	var t_balance_len = sqrt(sqr(t_balance_delta[0]) + sqr(t_balance_delta[1]));
	var tkMaxBalancePivotDistance = 12;
	// Limit distance
	if (t_balance_len > tkMaxBalancePivotDistance)
	{
		m_itemBalancePivot[0] = x + (t_balance_delta[0] / t_balance_len) * tkMaxBalancePivotDistance;
		m_itemBalancePivot[1] = y + (t_balance_delta[1] / t_balance_len) * tkMaxBalancePivotDistance;
	}
}
