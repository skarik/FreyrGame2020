function aiScriptableUpdate() {
	// based on the AI style, change what we're doing

	// Apply the default script
	if (m_aiScript_style == kAiStyle_Default)
	{
		m_aiScript_style = kAiScriptDefaultStyle;
	}

	// If there's a request, change the script styles
	if (m_aiScript_requestStyle != null)
	{
		m_aiScript_style = m_aiScript_requestStyle;
		m_aiScript_requestStyle = null;
	}

	// Update the follow AI style
	if (m_aiScript_style == kAiStyle_Follow)
	{
		// Check for input commands:
		if (m_aiScript_requestCommand == kAiRequestCommand_Start)
		{
			m_aiFollowing = true;
			m_aiScript_requestCommand = null;
		}
		else if (m_aiScript_requestCommand == kAiRequestCommand_Stop)
		{
			m_aiFollowing = false;
			m_aiScript_requestCommand = null;
		}
	
		aiFollowerUpdate();
	}
	// Update via the scripted AI style
	else if (m_aiScript_style == kAiStyle_Scripted)
	{
		// Work on given commands
		if (m_aiScript_requestCommand == kAiRequestCommand_Move)
		{
			aipathMoveTo(m_aiScript_requestPositionX, m_aiScript_requestPositionY);
			if (m_aiScript_requestSpeed > 0.0)
			{
				xAxis.value *= m_aiScript_requestSpeed;
				yAxis.value *= m_aiScript_requestSpeed;
			}
			if (!moHitWall)
			{
				// Resume motion & reset wallbash if done
				m_aiScript_wallTimer = max(0.0, m_aiScript_wallTimer - Time.deltaTime);
				if (m_aiScript_wallTimer <= 0.0) {
					m_aiScript_wallBashCount = 0;
				}
			}
			else
			{
				m_aiScript_wallTimer += 5.0 * Time.deltaTime;
				if (m_aiScript_wallTimer >= 1.0)
				{
					m_aiScript_wallBashCount += 1; // Count wallbashes.
				
					// Stop input when smashing against a wall
					_controlStructUpdate(xAxis, 0.0);
					_controlStructUpdate(yAxis, 0.0);
				}
			}
			// Stop all bashing
			if (m_aiScript_wallBashCount >= 3)
			{
				// Stop input when smashing against a wall a ton
				_controlStructUpdate(xAxis, 0.0);
				_controlStructUpdate(yAxis, 0.0);
			}
		}
		else if (m_aiScript_requestCommand == kAiRequestCommand_Stop)
		{
			// Stop input when told to stop
			_controlStructUpdate(xAxis, 0.0);
			_controlStructUpdate(yAxis, 0.0);
		}
		else if (m_aiScript_requestCommand == kAiRequestCommand_Teleport)
		{
			m_aiScript_requestCommand = null;
			x = m_aiScript_requestPositionX;
			y = m_aiScript_requestPositionY;
			z_ready = false;
			z = collision3_get_highest_position(x, y, z);
		
			m_aiScript_requestPositionX = 0.0;
			m_aiScript_requestPositionY = 0.0;
		}
		else if (m_aiScript_requestCommand == kAiRequestCommand_Face)
		{
			aimotionFaceAt(m_aiScript_requestPositionX, m_aiScript_requestPositionY, -1);
		}
		else if (m_aiScript_requestCommand == kAiRequestCommand_FollowPath)
		{
			if (iexists(m_aiScript_requestPathnode))
			{
				// Wait in place
				if (m_aiScript_pathTimer > 0.0)
				{
					m_aiScript_pathTimer -= Time.deltaTime;
				
					_controlStructUpdate(xAxis, 0.0);
					_controlStructUpdate(yAxis, 0.0);
			
					aimotionFaceAtDirection(m_aiScript_requestPathnode.image_angle, 360);
			
					if (m_aiScript_pathTimer <= 0.0)
					{
						with (m_aiScript_requestPathnode)
						{
							event_user(kEvent_PathnodeOnPass1);
						}
						m_aiScript_requestPathnode = m_aiScript_requestPathnode.m_pathNext;
					}
				}
				// Go to next node
				else
				{
					// Move to the patrol target
					{
						var control_vector = [m_aiScript_requestPathnode.x - x, m_aiScript_requestPathnode.y - y];
						var control_vector_len = sqrt(sqr(control_vector[0]) + sqr(control_vector[1]));
						if (control_vector_len > 0.01)
						{
							control_vector[0] /= control_vector_len;
							control_vector[1] /= control_vector_len;
						}
						if (m_aiScript_requestSpeed > 0.0)
						{
							control_vector[0] *= m_aiScript_requestSpeed;
							control_vector[1] *= m_aiScript_requestSpeed;
						}
						_controlStructUpdate(xAxis, control_vector[0]);
						_controlStructUpdate(yAxis, control_vector[1]);
					}
				
					// If at the patrol point, move to the next point
					if (sqr(x - m_aiScript_requestPathnode.x) + sqr(y - m_aiScript_requestPathnode.y) < sqr(10))
					{
						if (m_aiScript_requestPathnode.m_pathPauseTime > 0.0)
						{	// Pause at it for a time
							m_aiScript_pathTimer = m_aiScript_requestPathnode.m_pathPauseTime;
						}
						else
						{	// Continue going instead
							with (m_aiScript_requestPathnode)
							{
								event_user(kEvent_PathnodeOnPass1);
							}
							m_aiScript_requestPathnode = m_aiScript_requestPathnode.m_pathNext;
						}
					}
				}
			}
			else
			{
				// Stop motion if node missing or path done
				_controlStructUpdate(xAxis, 0.0);
				_controlStructUpdate(yAxis, 0.0);
			
				// And done
				m_aiScript_requestCommand = null;
			}
		}
		else if (m_aiScript_requestCommand == kAiRequestCommand_Jump)
		{
			// Do blend
			m_aiScript_jumpTimer += Time.deltaTime / m_aiScript_requestSpeed * (m_aiScript_jumpDistance / kMoveSpeed) * 2;
		
			m_aiScript_jumpTimer = saturate(m_aiScript_jumpTimer);
			x = lerp(m_aiScript_jumpStartX, m_aiScript_requestPositionX, m_aiScript_jumpTimer);
			y = lerp(m_aiScript_jumpStartY, m_aiScript_requestPositionY, m_aiScript_jumpTimer);
			z = lerp(m_aiScript_jumpStartZ, m_aiScript_jumpTargetZ, m_aiScript_jumpTimer);
			z += sqrt(max(0.0, 0.5 - abs(0.5 - m_aiScript_jumpTimer))) * abs(m_aiScript_jumpStartZ - m_aiScript_jumpTargetZ) * 1.4;
		
			var t_znext = collision3_get_highest_meeting(x, y, z - 1024);
			z_height = z - t_znext; //max(0.0, z - t_znext);
			z -= z_height;
			//z = t_znext;
		
			moEnabled = false;
			xspeed = 0.0;
			yspeed = 0.0;
			zspeed = 0.0;
			onGround = (z_height > 4) ? false : true;
			moAnimationYOffset = 0.0;
			z_ready = false;
		
			if (m_aiScript_jumpTimer >= 1.0)
			{
				moEnabled = true;
				m_aiScript_requestCommand = null;
				m_aiScript_requestPositionX = 0.0;
				m_aiScript_requestPositionY = 0.0;
				z_ready = true;
				effectOnGroundHit(x, y);
			}
		}
	}
	// Update the leader AI style
	if (m_aiScript_style == kAiStyle_Lead)
	{
		// Check for input commands:
		if (m_aiScript_requestCommand == kAiRequestCommand_Start)
		{	
			m_aiLeadering = true;
			m_aiScript_requestCommand = null;
			m_aiLeader_targetX = m_aiScript_requestPositionX;
			m_aiLeader_targetY = m_aiScript_requestPositionY;
		
			//show_message(string(m_aiLeader_targetX) + " " + string(m_aiLeader_targetY));
		}
		else if (m_aiScript_requestCommand == kAiRequestCommand_Stop)
		{
			m_aiLeadering = false;
			m_aiScript_requestCommand = null;
		}
	
		aiLeaderUpdate();
	}

	// Update the cutstom AI style
	if (m_aiScript_style == kAiStyle_Custom)
	{
		aiCustomUpdate();
	}


}
