var cursor_x = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
var cursor_y = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));

var dx = m_base_x;
var dy = m_base_y;

if (m_book_state = BookState.TopLevel)
{
	// reset if mouse move
	if (o_PlayerTest.uPosition != o_PlayerTest.uPositionPrevious
		|| o_PlayerTest.vPosition != o_PlayerTest.vPositionPrevious)
	{
		m_top_hover = null;
	}
	
	// if mouse moved, then we check for hover
	if (m_top_hover == null)
	{
		/*var kBookWidth = 482;
		var kBookHeight = 298;
		var kXOffsetCenterLeft = 130;
		var kXOffsetCenterRight = kBookWidth - 130;
	
		var left = kXOffsetCenterLeft - 85;
		var right = kXOffsetCenterLeft + 85;
		var dy_rest0 = 70;
		var dy_rest1 = 150;*/
	
		// do rest checks
		if (m_top_hover == null)
		{
			var t_rect;
			
			t_rect = m_hover_rects[BookSelects.RestShort];
			if (point_in_rectangle(cursor_x, cursor_y,
								   t_rect[0], t_rect[1], t_rect[2], t_rect[3]))
			{
				m_top_hover = BookSelects.RestShort;
			}
			
			/*
			if (point_in_rectangle(cursor_x, cursor_y,
								   dx + left, dy + dy_rest1, dx + right, dy + dy_rest1 + 16))
			{
				m_top_hover = BookSelects.RestFull;
			}
			*/
		}
		// do rune checks
	
	
		// Perform directional controls
		if (o_PlayerTest.uvPositionStyle == kControlUvStyle_Unused)
		{
			/*var uv_info = playerUiControlCollectUV();
			var prevAxis = uv_info[0];
			var currAxis = uv_info[1];
			var prevAxisMagnitude = uv_info[2];
			var currAxisMagnitude = uv_info[3];
			var prevAxisNormalized = uv_info[4];
			var currAxisNormalized = uv_info[5];
			var axisDirectionChange = uv_info[6];*/
			// do rest checks
			// do rune checks
		}
	}
	
	if (m_top_hover != null)
	{
		if (o_PlayerTest.selectButton.pressed)
		{	// Update selected item.
			m_top_selection = m_top_hover;
			// Go to substate
			m_book_state = BookState.SelectionOptions;
			
			// Change the current option tab open.
			m_sub_selection = null;
			m_tri_selection = null;
		}
	}
}

if (m_book_state == BookState.SelectionOptions)
{
	// reset if mouse move
	if (o_PlayerTest.uPosition != o_PlayerTest.uPositionPrevious
		|| o_PlayerTest.vPosition != o_PlayerTest.vPositionPrevious)
	{
		m_sub_hover = null;
		m_tri_hover = null;
	}
	// if mouse moved, then we check for hover
	if (m_sub_hover == null)
	{
		if (m_sub_hover == null)
		{
			var t_rect;
			
			t_rect = m_hover_rects[BookSelects.RestShort_Confirm];
			if (point_in_rectangle(cursor_x, cursor_y,
								   t_rect[0], t_rect[1], t_rect[2], t_rect[3]))
			{
				m_sub_hover = BookSelects.RestShort_Confirm;
			}
			
			t_rect = m_hover_rects[BookSelects.RestShort_Duration];
			if (point_in_rectangle(cursor_x, cursor_y,
								   t_rect[0], t_rect[1], t_rect[2], t_rect[3]))
			{
				m_sub_hover = BookSelects.RestShort_Duration;
				m_tri_hover = (cursor_y < (t_rect[1] + t_rect[3]) * 0.5) ? -1 : +1;
			}
		}
		
		// Perform directional controls
		if (o_PlayerTest.uvPositionStyle == kControlUvStyle_Unused)
		{
			/*var uv_info = playerUiControlCollectUV();
			var prevAxis = uv_info[0];
			var currAxis = uv_info[1];
			var prevAxisMagnitude = uv_info[2];
			var currAxisMagnitude = uv_info[3];
			var prevAxisNormalized = uv_info[4];
			var currAxisNormalized = uv_info[5];
			var axisDirectionChange = uv_info[6];*/
			// do rest checks
			// do rune checks
		}
	}
	
	if (m_sub_hover != null)
	{
		if (o_PlayerTest.selectButton.pressed)
		{
			if (m_sub_hover == BookSelects.RestShort_Duration)
			{
				// Change duration 
				if (m_tri_hover > 0)
				{
					m_option_current_waittime -= 1;
				}
				else
				{
					m_option_current_waittime += 1;
				}
			}
			
			if (m_sub_hover == BookSelects.RestShort_Confirm)
			{
				// Close book
				m_player.m_usingBook = false;
				// Actually wait.
				gameCampWait(m_option_current_waittime);
			}
		}
		
		if (m_sub_hover == BookSelects.RestShort_Duration)
		{
			if (o_PlayerTest.yAxis.previous < 0.707 && o_PlayerTest.yAxis.value > 0.707)
			{
				// Decrement duration
				m_option_current_waittime -= 1;
			}
			if (o_PlayerTest.yAxis.previous > -0.707 && o_PlayerTest.yAxis.value < -0.707)
			{
				// Increment duration
				m_option_current_waittime += 1;
			}
		}
		
		// Limit waittime
		m_option_current_waittime = clamp(m_option_current_waittime, 1, 8);
	}
	
	if (m_book_state == BookState.SelectionOptions)
	{
		if (o_PlayerTest.cancelButton.pressed)
		{	// We want to cancel and go up a level
			m_book_state = BookState.TopLevel;
			m_top_selection = null;
		}
	}
}

// do top tabs
if (_playeruiBookInput_TopTabs()) exit;