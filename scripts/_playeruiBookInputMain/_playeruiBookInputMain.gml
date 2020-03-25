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
		var kBookWidth = 482;
		var kBookHeight = 298;
		var kXOffsetCenterLeft = 130;
		var kXOffsetCenterRight = kBookWidth - 130;
	
		var left = kXOffsetCenterLeft - 85;
		var right = kXOffsetCenterLeft + 85;
		var dy_rest0 = 70;
		var dy_rest1 = 150;
	
		// do rest checks
		if (m_top_hover == null)
		{
			if (point_in_rectangle(cursor_x, cursor_y,
								   dx + left, dy + dy_rest0, dx + right, dy + dy_rest0 + 16))
			{
				m_top_hover = BookSelects.RestShort;
			}
			if (point_in_rectangle(cursor_x, cursor_y,
								   dx + left, dy + dy_rest1, dx + right, dy + dy_rest1 + 16))
			{
				m_top_hover = BookSelects.RestFull;
			}
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
}

// do top tabs
if (_playeruiBookInput_TopTabs()) exit;