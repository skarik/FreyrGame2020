function playerUiUpdateBook() {
	//m_book_enabled

	if (iexists(o_menuPlayerBook))
	{
		m_book_totalBlend = o_menuPlayerBook.m_totalBlend;
	}
	else
	{
		m_book_totalBlend = max(0.0, m_book_totalBlend - Time.unscaledDeltaTime * 3.0);
	}

	/*if (o_PlayerTest.m_usingBook)
	{
		m_book_totalBlend = min(1.0, m_book_totalBlend + Time.unscaledDeltaTime * 3.0);
	}
	else
	{
		m_book_totalBlend = max(0.0, m_book_totalBlend - Time.unscaledDeltaTime * 3.0);
	}

	// perform page swapping
	if (o_PlayerTest.m_usingBook)
	{
		// todo: check click
		if (o_PlayerTest.prevUiButton.pressed)
		{
			if (m_book_tab <= 0) m_book_tab = 4;
			m_book_tab -= 1;
		}
		else if (o_PlayerTest.nextUiButton.pressed)
		{
			m_book_tab = (m_book_tab + 1) % 4;
		}
	}*/

	// loop through each menu item to get the current hover
	/*if (o_PlayerTest.m_usingBook)
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
			var uv_info = playerUiControlCollectUV();
			var prevAxis = uv_info[0];
			var currAxis = uv_info[1];
			var prevAxisMagnitude = uv_info[2];
			var currAxisMagnitude = uv_info[3];
			var prevAxisNormalized = uv_info[4];
			var currAxisNormalized = uv_info[5];
			var axisDirectionChange = uv_info[6];
		
			// Menu selection for the 5 choices
			if (m_book_main_selection == null)
			{
				m_book_main_hover = playerUiControlSelectFromArray(uv_info, m_book_main_hover, m_book_offsets_main, 32.0);
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
	}*/


}
