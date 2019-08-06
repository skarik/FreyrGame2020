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