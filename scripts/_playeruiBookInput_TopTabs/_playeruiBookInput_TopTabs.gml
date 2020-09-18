function _playeruiBookInput_TopTabs() {
	//if (m_book_state == BookState.TopLevel && m_top_hover == null)
	if (m_top_hover == null)
	{
		var kTabStartX = 50;
		var kTabDivX = 25;
		var kTabStartY = 9;
	
		var cursor_x = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
		var cursor_y = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));
	
		var dx = m_base_x;
		var dy = m_base_y;
	
		// Loop through all the tabs
		for (var i = 0; i < 4; ++i)
		{
			var ddx = dx + kTabStartX + kTabDivX * i;
			var ddy = dy + kTabStartY;
		
			if (point_in_rectangle(cursor_x, cursor_y,
									ddx - kTabDivX * 0.5, ddy - 20,
									ddx + kTabDivX * 0.5, ddy))
			{
				switch (i)
				{
					case 0: m_top_hover = BookSelects.TabMain; break;
					case 1: m_top_hover = BookSelects.TabMap; break;
					case 2: m_top_hover = BookSelects.TabRelationship; break;
					case 3: m_top_hover = BookSelects.TabOptions; break;
				}
				break;
			}
		}
	}

	// Do tab rolling
	if (o_PlayerTest.prevUiButton.pressed)
	{
		if (m_tab <= 0) m_tab = 4;
		m_tab -= 1;
	
		m_top_selection = null;
	
		m_anim_tab_flavor = 1.0; // Proc the animation hit
	
		sound_play_channel("audio/ui/book_pageturn.wav", kSoundChannelUi);
	}
	else if (o_PlayerTest.nextUiButton.pressed)
	{
		m_tab = (m_tab + 1) % 4;
	
		m_top_selection = null;
	
		m_anim_tab_flavor = 1.0; // Proc the animation hit
	
		sound_play_channel("audio/ui/book_pageturn.wav", kSoundChannelUi);
	}

	// Do tab-selection
	if (m_top_hover == BookSelects.TabMain
		|| m_top_hover == BookSelects.TabMap
		|| m_top_hover == BookSelects.TabRelationship
		|| m_top_hover == BookSelects.TabOptions)
	{
		if (selectButton.pressed)
		{
			var next_tab = m_top_hover - BookSelects.TabMain;
			if (m_tab != next_tab)
			{
				m_book_state = BookState.TopLevel;
				m_tab = next_tab;
				m_top_selection = null;
				m_sub_selection = null;
				m_tri_selection = null;
			
				m_anim_tab_flavor = 1.0; // Proc the animation hit
			
				sound_play_channel("audio/ui/book_pageturn.wav", kSoundChannelUi);
				return true;
			}
		}
	}

	return false;


}
