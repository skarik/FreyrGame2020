function aiLeaderUpdate() {
	if (m_aiLeadering)
	{
		var leaderTarget = o_PlayerTest;
	
		/*var followMoved = false;
		if (abs(m_aiFollow_targetX - followTarget.x) > 3 || abs(m_aiFollow_targetY - followTarget.y) > 3)
		{
			m_aiFollow_targetX = followTarget.x;
			m_aiFollow_targetY = followTarget.y;
			followMoved = true;
		}*/
		var leaderFollowDistance = point_distance(x, y, leaderTarget.x, leaderTarget.y);
		var leaderDistance = point_distance(x, y, m_aiLeader_targetX, m_aiLeader_targetY);
	
		// We want to enter the following state if we're in most states
		/*if (m_aiFollow_state == kAiFollowState_Waiting
			|| m_aiFollow_state == kAiFollowState_Wandering)
		{
			// Is the follow target far away? If so, we want to move towards them.
			if (followDistance > kAiFollowBeginDistance)
			{
				m_aiFollow_state = kAiFollowState_Following;
				m_aiFollow_timer = 0.0;
			}
		}
	
		// We want to enter backing off in all states
		if (m_aiFollow_state == kAiFollowState_Waiting
			|| m_aiFollow_state == kAiFollowState_Wandering
			|| m_aiFollow_state == kAiFollowState_Following)
		{
			// If we're too close to the follow distance (and the follow target is moving), we want to back off.
			if (followDistance < 12.0 && followMoved)
			{
				m_aiFollow_state = kAiFollowState_BackingOff;
				m_aiFollow_timer = 0.0;
			}
		}*/
	
		// Non-overriding states:
		switch (m_aiLeader_state)
		{
		case kAiLeaderState_Waiting:
			{
				// Clear out the motion axes
				_controlStructUpdate(xAxis, 0.0);
				_controlStructUpdate(yAxis, 0.0);
			
				// If too far from charge, go back
				if (leaderFollowDistance > kAiLeaderCatchupDistance)
				{
					m_aiLeader_state = kAiLeaderState_Backtracking;
				}
				else if (leaderFollowDistance < kAiLeaderBeginDistance)
				{
					m_aiLeader_state = kAiLeaderState_Leading;
				}
			}
			break;
		case kAiLeaderState_Backtracking:
			{
				// We want to move to the player. TODO: pathfinding.
				if (leaderFollowDistance > kAiLeaderCatchupDistance)
				{
					/*var follow_dir_x = (leaderTarget.x - x) / leaderFollowDistance;
					var follow_dir_y = (leaderTarget.y - y) / leaderFollowDistance;

					// Update the motion axes to the given motion
					_controlStructUpdate(xAxis, follow_dir_x);
					_controlStructUpdate(yAxis, follow_dir_y);*/
					aipathMoveTo(leaderTarget.x, leaderTarget.y);
				}
				else
				{
					// We caught up, it's time to go back to standing
					m_aiLeader_state = kAiLeaderState_Waiting;
				}
			}
			break;
		case kAiLeaderState_Leading:
			{
				// Move to the lead target
				aipathMoveTo(m_aiLeader_targetX, m_aiLeader_targetY);
			
				// Wait for the player if they fall behind
				if (leaderFollowDistance > kAiLeaderBeginDistance)
				{
					m_aiLeader_state = kAiLeaderState_Waiting;
				}
			}
			break;
		}
	}
	else
	{
		// Clear out the motion axes
		_controlStructUpdate(xAxis, 0.0);
		_controlStructUpdate(yAxis, 0.0);
	}


}
