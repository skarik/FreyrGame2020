//m_book_enabled

if (o_PlayerTest.m_usingBook)
{
	m_book_totalBlend = min(1.0, m_book_totalBlend + Time.deltaTime * 3.0);
}
else
{
	m_book_totalBlend = max(0.0, m_book_totalBlend - Time.deltaTime * 3.0);
}

// loop through each menu item to get the current hover
if (o_PlayerTest.m_usingBook)
{
	var cursor_x = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
	var cursor_y = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));
	
	// reset if mouse move
	if (o_PlayerTest.uPosition != o_PlayerTest.uPositionPrevious
		|| o_PlayerTest.vPosition != o_PlayerTest.vPositionPrevious)
	{
		m_book_main_hover = null;
	}
	//Check which item the mouse is hovering over
	if (m_book_main_hover == null)
	{
		for (var i = 0; i < ((m_book_main_selection == null) ? 5 : 7); ++i)
		{
			var offsets = m_book_offsets_main[i];
			var check_x = m_book_base_x + offsets[0];
			var check_y = m_book_base_y + offsets[1];
	
			if (sqr(check_x - cursor_x) + sqr(check_y - cursor_y) < sqr(25))
			{
				m_book_main_hover = i;
				break;
			}
		}
	}
	// Perform directional controls
	if (o_PlayerTest.uvPositionStyle == kControlUvStyle_Unused)
	{
		var prevAxis = [o_PlayerTest.uAxis.previous, o_PlayerTest.vAxis.previous];
		var currAxis = [o_PlayerTest.uAxis.value, o_PlayerTest.vAxis.value];
			
		var prevAxisMagnitude = avec2_length(prevAxis);
		var currAxisMagnitude = avec2_length(currAxis);
		
		var prevAxisNormalized = avec2_divide(prevAxis, prevAxisMagnitude);
		var currAxisNormalized = avec2_divide(currAxis, currAxisMagnitude);
		
		var axisDirectionChange = avec2_dot(prevAxisNormalized, currAxisNormalized);
		
		// Menu selection for the 5 choices
		if (m_book_main_selection == null)
		{
			if ((prevAxisMagnitude < kControlChoice_Margin && currAxisMagnitude >= kControlChoice_Margin)
				|| axisDirectionChange < 0.8)
			{
				var l_currOptionPos = [0, 0];
				if (m_book_main_hover != null)
					l_currOptionPos = m_book_offsets_main[m_book_main_hover];
				var l_checkPos = [
					l_currOptionPos[0] + currAxisNormalized[0] * 32,
					l_currOptionPos[1] + currAxisNormalized[1] * 32
					];
				var l_closestChoice = null;
				var l_closestDistance = 1000;
				
				// Find the next closest option to the direction we're going:
				for (var i = 0; i < 5; ++i) 
				{
					if (i == m_book_main_hover) continue;
					
					var l_checkOptionPos = m_book_offsets_main[i];
					var l_checkDelta = avec2_subtract(l_checkOptionPos, l_checkPos);
					
					// Make sure the option is in the cone of the direction
					var l_checkDeltaNormalized = avec2_normalized(l_checkDelta);
					if (avec2_dot(l_checkDeltaNormalized, currAxisNormalized) < 0.0)
						continue;
					
					// Make sure the option is the closest
					var l_checkDistance = avec2_length(l_checkDelta);
					if (l_checkDistance < l_closestDistance)
					{
						l_closestChoice = i;
						l_closestDistance = l_checkDistance;
					}
				}
				
				if (l_closestChoice != null)
				{
					m_book_main_hover = l_closestChoice;
				}
			}
			m_book_main_hover = clamp(m_book_main_hover, 0, 4);
		}
		// Selecting accept or cancel
		else
		{
			if ((prevAxisMagnitude < kControlChoice_Margin && currAxisMagnitude >= kControlChoice_Margin)
				|| axisDirectionChange < 0.8)
			{
				m_book_main_hover += sign(currAxis[0] + currAxis[1]);
			}
			m_book_main_hover = clamp(m_book_main_hover, 5, 6);
		}
	}
}
else
{
	m_book_main_hover = null;
	m_book_main_selection = null;
	
	// force exit options
	if (m_book_tab == Tabs.kOptions)
	{
		m_book_tab = Tabs.kMain;
	}
}

// do click logic
if (o_PlayerTest.m_usingBook && m_book_tab == Tabs.kMain)
{
	if (m_book_main_selection == null)
	{
		if (m_book_main_hover != null)
		{
			if (o_PlayerTest.selectButton.pressed)
			{	// Update selected item.
				m_book_main_selection = m_book_main_hover;
				
				// If options clicked...
				if (m_book_main_hover == 3)
				{	// Update tab
					m_book_tab = Tabs.kOptions;
				}
			}
		}
		if (o_PlayerTest.cancelButton.pressed)
		{	// We want to put away the book
			o_PlayerTest.m_usingBook = false;
		}
	}
	else if (m_book_main_selection != null)
	{
		if (m_book_main_hover != 5 && m_book_main_hover != 6)
		{
			if (o_PlayerTest.selectButton.pressed)
			{	// Update selected item.
				m_book_main_selection = m_book_main_hover;
				
				// If options clicked...
				if (m_book_main_hover == 3)
				{	// Update tab
					m_book_tab = Tabs.kOptions;
				}
			}
			else if (o_PlayerTest.cancelButton.pressed)
			{	// Clear out selection
				m_book_main_selection = null;
			}
		}
		else if (m_book_main_hover == 6)
		{
			if (o_PlayerTest.selectButton.pressed || o_PlayerTest.cancelButton.pressed)
			{	// Clear out selection
				m_book_main_selection = null;
			}
		}
		else if (m_book_main_hover == 5)
		{
			if (o_PlayerTest.cancelButton.pressed)
			{	// Clear out selection
				m_book_main_selection = null;
			}
			else if (o_PlayerTest.selectButton.pressed)
			{
				// Depending on the selection, do different things
				if (m_book_main_selection == 0)
				{	// Wait
					gameCampWait(3.0);
					o_PlayerTest.m_usingBook = false;
				}
				else if (m_book_main_selection == 1)
				{	// make camp
					gameCampUntilMorning();
					o_PlayerTest.m_usingBook = false;
				}
				else if (m_book_main_selection == 2)
				{	// save game
					gameBookSave();
					o_PlayerTest.m_usingBook = false;
				}
				else if (m_book_main_selection == 3)
				{} // Options are handled like a tab. No confirmation needed
				else if (m_book_main_selection == 4)
				{	// quit game
					gameBookQuit();
					o_PlayerTest.m_usingBook = false;
				}
			}
		}
	}
}