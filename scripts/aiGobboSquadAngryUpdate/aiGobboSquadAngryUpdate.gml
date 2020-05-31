/*
// Set up squad stuff
m_aiGobbo_squadSize = 0;
m_aiGobbo_squadLeader = null;
m_aiGobbo_squadMember = null;
m_aiGobbo_squad = array_create(0);
*/

#region Update Squad

// Look for a squad leader if we don't have one
if (!iexists(m_aiGobbo_squadLeader) || m_aiGobbo_squadLeader.m_isDead)
{
	// If we have a squad, select a new leader
	if (array_length_1d(m_aiGobbo_squad) != 0)
	{
		for (var i = 0; i < array_length_1d(m_aiGobbo_squad); ++i)
		{
			if (iexists(m_aiGobbo_squad[i]))
			{
				m_aiGobbo_squadLeader = m_aiGobbo_squad[i];
				break;
			}
		}
		aiGobboSquad_SetLeader(m_aiGobbo_squadLeader, m_aiGobbo_squad);
	}
	// If we have no squad, find a squad
	else
	{
		aiGobboSquad_CreateSquad();
		aiGobboSquad_SetLeader(id, m_aiGobbo_squad);
		
		// Zero out the squad age
		for (var i = 0; i < array_length_1d(m_aiGobbo_squad); ++i)
		{
			if (iexists(m_aiGobbo_squad[i]))
			{
				m_aiGobbo_squad[i].m_aiGobbo_squadAge = 0.0;
			}
		}
	}
}
else
{
	// Refresh squad every N amount of time
	if (m_aiGobbo_squadAge > 1.0)
	{
		// Zero out the squad age every N amount of time so only self can update
		for (var i = 0; i < array_length_1d(m_aiGobbo_squad); ++i)
		{
			if (iexists(m_aiGobbo_squad[i]))
			{
				m_aiGobbo_squad[i].m_aiGobbo_squadAge = 0.0;
			}
		}
		// Find a new squad:
		aiGobboSquad_CreateSquad();
		aiGobboSquad_SetLeader(id, m_aiGobbo_squad);
	}
	m_aiGobbo_squadAge += Time.deltaTime;
}

#endregion

#region Update Anger Target

var m_angerTarget = null;
m_angerTarget = getPlayer();

var m_angerTargetPos = [x, y];
if (iexists(m_angerTarget))
{
	var m_angerTargetPos = [m_angerTarget.x, m_angerTarget.y];
}

#endregion

#region Squad Leader Gives Commands

if (m_aiGobbo_squadLeader == id)
{
	if (iexists(m_angerTarget))
	{
		// Update the position sparingly
		m_aiGobbo_squadManage_PositionTimer -= Time.deltaTime;
		if (m_aiGobbo_squadManage_PositionTimer < 0.0)
		{
			m_aiGobbo_squadManage_PositionCenter = m_angerTargetPos;
			m_aiGobbo_squadManage_PositionTimer = 2.0;
		}
		
		// Hand out the position commands first:
		var squad_size = array_length_1d(m_aiGobbo_squad);
		var squad_angle_div = 360 / squad_size;
		var squad_hover_dist = 50 + squad_size * 10;
		var squad_angle_offset = Time.time * 10.0;
		
		for (var i = 0; i < squad_size; ++i)
		{
			var gobbo = m_aiGobbo_squad[i];
			if (iexists(gobbo))
			{
				if (gobbo.m_aiGobbo_squadStateCase != kAiGobboSquadStateCase_Hesitate)
				{
					gobbo.m_aiGobbo_squadStateTargetPosition = [
						m_aiGobbo_squadManage_PositionCenter[0] + lengthdir_x(squad_hover_dist, squad_angle_offset + i * squad_angle_div),
						m_aiGobbo_squadManage_PositionCenter[1] + lengthdir_y(squad_hover_dist, squad_angle_offset + i * squad_angle_div)];
				}
				// If not the leader, we want to end any hesitation
				else if (gobbo != m_aiGobbo_squadLeader)
				{
					if (gobbo.m_aiGobbo_squadStateTime < 0.35 && !gobbo.m_isStunned && squad_size > 1) {
						gobbo.m_aiGobbo_squadStateTime += Time.deltaTime;
					}
					else {
						gobbo.m_aiGobbo_squadStateTime = 0.0;
						gobbo.m_aiGobbo_squadStateCase = kAiGobboSquadStateCase_Hover;
					}
				}
			}
		}
		
		var timerPrev = m_aiGobbo_squadManage_MasterTimer;
		
		// Update the command timer (1.0 seconds per attacker)
		if (!m_isStunned)
		{
			m_aiGobbo_squadManage_MasterTimer += Time.deltaTime;
		}
		else
		{	// Increase rate of attacks if getting hit
			m_aiGobbo_squadManage_MasterTimer = max(0.0, m_aiGobbo_squadManage_MasterTimer);
		}
		
		// Squad leader needs to stop and point. So at the start of command timer, give gobbo the attack signal.
		if (timerPrev <= 0.0 && m_aiGobbo_squadManage_MasterTimer > 0.0)
		{
			var gobbo_attacker = m_aiGobbo_squad[m_aiGobbo_squadManage_Attacker];
			if (gobbo_attacker != id) // If the leader is not the attacker, then we signal
			{
				m_aiGobbo_squadStateCase = kAiGobboSquadStateCase_Hesitate;
				moAnimationExternal = true;
				
				sprite_index = kAnimSignal;
				animationIndex = 0.0;
				animationSpeed = 20;
			}
		}
		
		// Interrupt the pointing/signalling if stunned
		if (m_isStunned && m_aiGobbo_squadManage_MasterTimer < 0.5)
		{
			moAnimationExternal = false;
		}
		
		// After the signal, we want to go for an attack.
		if (timerPrev < 0.5 && m_aiGobbo_squadManage_MasterTimer >= 0.5)
		{
			var gobbo_attacker = m_aiGobbo_squad[m_aiGobbo_squadManage_Attacker];
			if (iexists(gobbo_attacker))
			{
				// Make the gobbo attack after signal up for 0.5 s
				gobbo_attacker.m_aiGobbo_squadStateCase = kAiGobboSquadStateCase_AttackToHesitate;
				gobbo_attacker.m_aiGobbo_squadStateTime = 0.0;
			}
			// If the leader signaled (is not the attacker) we need to resume motion now
			if (gobbo_attacker != id)
			{
				m_aiGobbo_squadStateCase = kAiGobboSquadStateCase_Hover;
				moAnimationExternal = false;
			}
		}
		
		// Attempt to go to next attack command
		if (m_aiGobbo_squadManage_MasterTimer >= 1.0)
		{
			// Has the target gobbo attacked?
			var gobbo_attacker = m_aiGobbo_squad[m_aiGobbo_squadManage_Attacker];
			if (iexists(gobbo_attacker))
			{
				if (gobbo_attacker.m_aiGobbo_squadStateCase != kAiGobboSquadStateCase_AttackToHesitate
					&& gobbo_attacker.m_aiGobbo_squadStateCase != kAiGobboSquadStateCase_AttackToHover)
				{
					// Move onto next attacker:
					m_aiGobbo_squadManage_Attacker = (m_aiGobbo_squadManage_Attacker + 1) % squad_size;
					// Reset timer (plus some delay)
					m_aiGobbo_squadManage_MasterTimer = 0.0 - random(1.0);
				}
			}
		}
	}
	else
	{
		// TODO: Do something else...
	}
}

#endregion

#region Each Gobbo Follows Commands

if (m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_Hover)
{
	var dist_sqr = sqr(x - m_aiGobbo_squadStateTargetPosition[0]) + sqr(y - m_aiGobbo_squadStateTargetPosition[1]);
	if (dist_sqr > 4)
	{
		aipathMoveTo(m_aiGobbo_squadStateTargetPosition[0], m_aiGobbo_squadStateTargetPosition[1]);
	}
	else
	{
		_controlStructUpdate(xAxis, 0.0);
		_controlStructUpdate(yAxis, 0.0);
	}
	aimotionFaceAt(m_angerTargetPos[0], m_angerTargetPos[1], -1);
	
	// Stop any signalling when walking
	moAnimationExternal = false;
}
else if (m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_Hesitate)
{
	//aipathMoveTo(m_aiGobbo_squadStateTargetPosition[0], m_aiGobbo_squadStateTargetPosition[1]);
	_controlStructUpdate(xAxis, 0.0);
	_controlStructUpdate(yAxis, 0.0);
	_controlStructUpdate(atkButton, 0.0);
}
// Perform attack
else if (m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_AttackToHesitate
		|| m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_AttackToHover)
{
	var kChaseTime = 1.5;
	
	// Pre attack: run up and attack!
	if (m_aiGobbo_squadStateTime < kChaseTime)
	{
		m_aiGobbo_squadStateTime += Time.deltaTime;
		
		// Move up to the target we're attacking
		var dir = point_direction(x, y, m_angerTargetPos[0], m_angerTargetPos[1]);
		aipathMoveTo(m_angerTargetPos[0] + lengthdir_x(60, dir), m_angerTargetPos[1] + lengthdir_y(60, dir));
		
		var target_dist_sqr = sqr(x - m_angerTargetPos[0]) + sqr(y - m_angerTargetPos[1]);
		if (target_dist_sqr < sqr(26))
		{
			// Make them attack when close enough
			_controlStructUpdate(atkButton, 1.0);
			// fix facing for the attack
			aimotionFaceAt(m_angerTargetPos[0], m_angerTargetPos[1], -1);
			
			// Increment timer
			m_aiGobbo_squadStateTime = kChaseTime + 0.01;
			
			// Have a chance to do a combo:
			var combo_percent = 0.33;
			if (stats.m_health < stats.m_healthMax * 0.5) combo_percent = 0.67; // Increase chance on low health
			if (random(1.0) < combo_percent)
			{	// Continue to keep attacking in that case
				m_aiGobbo_squadStateTime = 0.0 - atkButton;
			}
		}
		else
		{
			//m_aiGobbo_squadStateTime = min(m_aiGobbo_squadStateTime, 0.4);
		}
	}
	// Post attack: do either return to hover to hesitate
	else
	{
		// Stop attacking
		_controlStructUpdate(atkButton, 0.0);
		
		if (m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_AttackToHesitate)
		{
			m_aiGobbo_squadStateCase = kAiGobboSquadStateCase_Hesitate;
		}
		else if (m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_AttackToHover)
		{
			m_aiGobbo_squadStateCase = kAiGobboSquadStateCase_Hover;
		}
		// Reset timer!
		m_aiGobbo_squadStateTime = 0.0;
	}
	
	// Stop any signalling when attacking
	moAnimationExternal = false;
}

#endregion