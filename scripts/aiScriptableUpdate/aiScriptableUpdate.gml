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
if (m_aiScript_style == kAiStyle_Scripted)
{
	// Work on given commands
	if (m_aiScript_requestCommand == kAiRequestCommand_Move)
	{
		aipathMoveTo(m_aiScript_requestPositionX, m_aiScript_requestPositionY);
	}
	else if (m_aiScript_requestCommand == kAiRequestCommand_Stop)
	{
		// Stop input when told to stop
		_controlStructUpdate(xAxis, 0.0);
		_controlStructUpdate(yAxis, 0.0);
	}
	else if (m_aiScript_requestCommand == kAiRequestCommand_Move)
	{
		m_aiScript_requestCommand = null;
		x = m_aiScript_requestPositionX;
		y = m_aiScript_requestPositionY;
	}
}