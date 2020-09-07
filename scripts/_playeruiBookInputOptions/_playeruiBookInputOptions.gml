function _playeruiBookInputOptions() {
	var cursor_x = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
	var cursor_y = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));

	var dx = m_base_x;
	var dy = m_base_y;

	//if (m_book_state == BookState.TopLevel)
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
	
			// do rest option checks
			if (m_top_hover == null)
			{
				for (var i = 100; i < 200; ++i)
				{
					var t_rect = m_hover_rects[i];
					if (is_array(t_rect)
						&& point_in_rectangle(cursor_x, cursor_y,
											  t_rect[0], t_rect[1], t_rect[2], t_rect[3]))
					{
						m_top_hover = i;
						break;
					}
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
	
		if (m_top_hover != null)
		{
			if (o_PlayerTest.selectButton.pressed)
			{	// Update selected item.
				m_top_selection = m_top_hover;
				// Go to substate
				m_book_state = BookState.SelectionOptions;
			
				// Change the current option tab open.
				if (m_option_current_choice != m_top_selection - BookSelects.OptionBase)
				{
					m_option_current_choice = m_top_selection - BookSelects.OptionBase;
					m_sub_scroll = 0;
					m_sub_selection = null;
					m_tri_selection = null;
				
					faudio_play_sound("audio/ui/book_select.wav", 50, false, kSoundChannelUi);
				}
			}
		}
	
		if (m_book_state == BookState.TopLevel)
		{
			if (o_PlayerTest.cancelButton.pressed)
			{	// We want to put away the book
				o_PlayerTest.m_usingBook = false;
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
			/*var kBookWidth = 482;
			var kBookHeight = 298;
			var kXOffsetCenterLeft = 130;
			var kXOffsetCenterRight = kBookWidth - 130;
	
			var left = kXOffsetCenterLeft - 85;
			var right = kXOffsetCenterLeft + 85;
			var dy_rest0 = 70;
			var dy_rest1 = 150;*/
	
			// do rest option checks
			if (m_sub_hover == null)
			{
				for (var i = 200; i < 300; ++i)
				{
					var t_rect = m_hover_rects[i];
					if (is_array(t_rect)
						&& point_in_rectangle(cursor_x, cursor_y,
											  t_rect[0], t_rect[1], t_rect[2], t_rect[3]))
					{
						m_sub_hover = i;
						break;
					}
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
		// if mouse moved, then we check for x/y checks
		if (m_tri_hover == null)
		{
			if (m_tri_hover == null)
			{
				for (var i = BookSelects.Option_TriOptionBase; i < BookSelects.Option_TriOptionBase + 4; ++i)
				{
					var t_rect = m_hover_rects[i];
					if (is_array(t_rect)
						&& point_in_rectangle(cursor_x, cursor_y,
											  t_rect[0], t_rect[1], t_rect[2], t_rect[3]))
					{
						m_tri_hover = i - BookSelects.Option_TriOptionBase;
						break;
					}
				}
			}
		}
	
		if (m_sub_hover != null)
		{
			// Update selected item.
			//m_top_selection = m_top_hover;
			// Go to substate
			//m_book_state = BookState.SelectionOptions;
			//m_option_current_choice = m_top_selection - BookSelects.OptionBase;
			if (m_sub_hover == BookSelects.Option_ViewUp)
			{
				if (o_PlayerTest.selectButton.pressed)
				{
					m_sub_scroll -= 16;
				}
			}
		
			if (m_sub_hover == BookSelects.Option_ViewDown)
			{
				if (o_PlayerTest.selectButton.pressed)
				{
					m_sub_scroll += 16;
				}
			}
		
			if (o_PlayerTest.cancelButton.pressed)
			{	// We want to go back up to the top level
				m_book_state = BookState.TopLevel;
				m_top_selection = null;
				m_sub_selection = null;
				m_tri_selection = null;
			}
			
			var option_index = m_sub_hover - BookSelects.Option_OptionBase;
			
			if (option_index >= 0 && option_index < array_length_1d(m_options))
			{
				var l_current_option = m_options[option_index];
				
				switch (ssettingGetType(l_current_option[3]))
				{
					case kSettingTypeControl:
					{
						if (m_tri_hover != null)
						{
							if (o_PlayerTest.selectButton.pressed)
							{
								// Confirm the selection
								m_sub_selection = m_sub_hover;
								m_tri_selection = m_tri_hover;
								m_tri_ready = false;
							
								// Move to control setting mode
								m_book_state = BookState.SubsetLevel;
							}
						}
					} break;
				
					case kSettingTypeFloat:
					{	
						var float_value = ssettingGetValue(l_current_option[3]);
						var float_min = ssettingGetMin(l_current_option[3]);
						var float_max = ssettingGetMax(l_current_option[3]);
					
						if (o_PlayerTest.selectButton.pressed)
						{
							var float_rect = m_hover_rects[m_sub_hover];
							var float_centerpoint = lerp(float_rect[0], float_rect[2], 0.75);
						
							if (cursor_x < float_centerpoint)
								float_value -= (float_max - float_min) * 0.1;
							else
								float_value += (float_max - float_min) * 0.1;
							float_value = clamp(float_value, float_min, float_max);
							
							ssettingSetValue(l_current_option[3], float_value);
							faudio_play_sound("audio/ui/book_select2.wav", 50, false, kSoundChannelUi);
						}
						else if (o_PlayerTest.xAxis.value > kControlChoice_Margin
								&& o_PlayerTest.xAxis.previous < kControlChoice_Margin)
						{
							float_value += (float_max - float_min) * 0.1;
							float_value = clamp(float_value, float_min, float_max);
							
							ssettingSetValue(l_current_option[3], float_value);
							faudio_play_sound("audio/ui/book_select2.wav", 50, false, kSoundChannelUi);
						}
						else if (o_PlayerTest.xAxis.value < -kControlChoice_Margin
								&& o_PlayerTest.xAxis.previous > -kControlChoice_Margin)
						{
							float_value -= (float_max - float_min) * 0.1;
							float_value = clamp(float_value, float_min, float_max);
							
							ssettingSetValue(l_current_option[3], float_value);
							faudio_play_sound("audio/ui/book_select2.wav", 50, false, kSoundChannelUi);
						}
					} break;
				
					case kSettingTypeEnum:
					{
						var enum_value = ssettingGetValue(l_current_option[3]);
						var enum_min = ssettingGetMin(l_current_option[3]);
						var enum_max = ssettingGetMax(l_current_option[3]);
					
						if (o_PlayerTest.selectButton.pressed)
						{
							var enum_rect = m_hover_rects[m_sub_hover];
							var enum_centerpoint = lerp(enum_rect[0], enum_rect[2], 0.67);
						
							if (cursor_x < enum_centerpoint)
								enum_value -= 1;
							else
								enum_value += 1;
							enum_value = clamp(enum_value, enum_min, enum_max);
							
							ssettingSetValue(l_current_option[3], enum_value);
							faudio_play_sound("audio/ui/book_select2.wav", 50, false, kSoundChannelUi);
						}
						else if (o_PlayerTest.xAxis.value > kControlChoice_Margin
								&& o_PlayerTest.xAxis.previous < kControlChoice_Margin)
						{
							enum_value += 1;
							enum_value = clamp(enum_value, enum_min, enum_max);
							
							ssettingSetValue(l_current_option[3], enum_value);
							faudio_play_sound("audio/ui/book_select2.wav", 50, false, kSoundChannelUi);
						}
						else if (o_PlayerTest.xAxis.value < -kControlChoice_Margin
								&& o_PlayerTest.xAxis.previous > -kControlChoice_Margin)
						{
							enum_value -= 1;
							enum_value = clamp(enum_value, enum_min, enum_max);
							
							ssettingSetValue(l_current_option[3], enum_value);
							faudio_play_sound("audio/ui/book_select2.wav", 50, false, kSoundChannelUi);
						}
					} break;
				
					case kSettingTypeBoolean:
					{
						if (o_PlayerTest.selectButton.pressed)
						{
							ssettingSetValue(l_current_option[3], !ssettingGetValue(l_current_option[3]));
							faudio_play_sound("audio/ui/book_select2.wav", 50, false, kSoundChannelUi);
						}
					} break;
				}
			}
		}
	}
	else if (m_book_state == BookState.SubsetLevel)
	{
		if (o_PlayerTest.cancelButton.pressed)
		{	// We want to go back up to the top level
			m_book_state = BookState.SelectionOptions;
			m_sub_selection = null;
			m_tri_selection = null;
		}
	
		// Grab the current option
		var option_index = m_sub_selection - BookSelects.Option_OptionBase;
			
		if (option_index >= 0 && option_index < array_length_1d(m_options))
		{
			var l_current_option = m_options[option_index];
		
			if (ssettingGetType(l_current_option[3]) == kSettingTypeControl)
			{
				var new_input = [null, null];
	
				// Check for any input:
			
				// Keyboard:
				for (var i = 1; i < 254; ++i)
				{
					if (i == vk_anykey || i == vk_nokey)
						continue;
					if (keyboard_check_direct(i))
					{
						new_input[0] = kControlKB;
						new_input[1] = i;
					}
				}
				// Mouse:
				if (mouse_check_button_pressed(mb_left))
					new_input = [kControlMouse, mb_left];
				if (mouse_check_button_pressed(mb_right))
					new_input = [kControlMouse, mb_right];
				if (mouse_check_button_pressed(mb_middle))
					new_input = [kControlMouse, mb_middle];
				if (mouse_wheel_up())
					new_input = [kControlMouse, kMouseWheelUp];
				if (mouse_wheel_down())
					new_input = [kControlMouse, kMouseWheelDown];
				// Controller:
				var gp_buttons = [gp_face1, gp_face2, gp_face3, gp_face4, gp_padd, gp_padu, gp_padl, gp_padr,
								  gp_select, gp_start, gp_stickl, gp_stickr,
								  gp_shoulderl, gp_shoulderlb, gp_shoulderr, gp_shoulderrb];
				for (var i = 0; i < array_length_1d(gp_buttons); ++i)
					if (gamepad_button_check_pressed(0, gp_buttons[i]))
						new_input = [kControlGamepad, gp_buttons[i]];
				var gp_axis;
				gp_axis = gamepad_axis_value(0, gp_axislh);
				if (abs(gp_axis) > 0.707)
					new_input = [kControlGamepad, gp_axislh * sign(gp_axis)];
				gp_axis = gamepad_axis_value(0, gp_axislv);
				if (abs(gp_axis) > 0.707)
					new_input = [kControlGamepad, gp_axislv * sign(gp_axis)];
				gp_axis = gamepad_axis_value(0, gp_axisrh);
				if (abs(gp_axis) > 0.707)
					new_input = [kControlGamepad, gp_axisrh * sign(gp_axis)];
				gp_axis = gamepad_axis_value(0, gp_axisrv);
				if (abs(gp_axis) > 0.707)
					new_input = [kControlGamepad, gp_axisrv * sign(gp_axis)];

				// Wait for ready state
				if (!m_tri_ready)
				{
					if (new_input[0] == null)
					{
						m_tri_ready = true;
					}
				}

				// Rebind for the array
				if (m_tri_ready && new_input[0] != null)
				{
					var control_value = ssettingGetValue(l_current_option[3]);
		
					// Fill in the empty spots in the array
					for (var i = array_length_1d(control_value); i < 8; ++i)
					{
						control_value[i] = null;
					}
				
					// Set the new control value
					control_value[m_tri_selection * 2 + 0] = new_input[0];
					control_value[m_tri_selection * 2 + 1] = new_input[1];
				
					ssettingSetValue(l_current_option[3], control_value);
				
					// Leave the state
					m_book_state = BookState.SelectionOptions;
					m_sub_selection = null;
					m_tri_selection = null;
				}
			} // End control type check
		}
	}

	// do top tabs
	if (_playeruiBookInput_TopTabs()) exit;


}
