/// @description Unified book draw

var c_bookHeading = make_color_rgb(165, 98, 67);
var c_bookHeadingShadow = make_color_rgb(207, 182, 144);

var kBookWidth = 482;
var kBookHeight = 298;
var kXOffsetCenterLeft = 130;
var kXOffsetCenterRight = kBookWidth - 130;

var kTabStartX = 50;
var kTabDivX = 25;
var kTabStartY = 9;

var dx, dy;
dx = ((Screen.width / Screen.pixelScale) - kBookWidth) / 2;
dy = round(((Screen.height / Screen.pixelScale) - kBookHeight) * 1.0 - 16.0);
dy += sqr(1.0 - saturate(m_totalBlend)) * 316; // Slide the book in from the bottom

m_base_x = dx;
m_base_y = dy;

// Disable alpha-channel blending for most of this.
gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one);

// Draw the book base!
draw_sprite_ext(sui_book2Pages, 0, dx, dy, 1.0, 1.0, 0.0, c_white, 1.0);

for (var i = 0; i < 4; ++i)
{
	var ddx = dx + kTabStartX + kTabDivX * i;
	var ddy = dy + kTabStartY + round(sin(i * 2.11) * 1.49);
	draw_sprite(sui_bookTabs, i % 3, ddx, ddy);
	draw_sprite_ext(sui_bookTabIcons, i, ddx, ddy, 1, 1, 0, c_maroon, 1.0);
	
	if (m_tab == i || m_top_hover == i)
	{
		draw_sprite(sui_bookTabIcons, i, ddx, ddy);
	}
}

// draw controls for the tabs
var l_actualControlType = m_player.lastControlType;
if (l_actualControlType == kControlKB)
	l_actualControlType = kControlMouse;
drawControl(dx + kTabStartX - kTabDivX * 1 + 3, dy + kTabStartY - 20, null, kControlDrawStyle_Flat, Settings.ctUiPrevious, l_actualControlType, m_player.lastGamepadType);
drawControl(dx + kTabStartX + kTabDivX * 4 - 3, dy + kTabStartY - 20, null, kControlDrawStyle_Flat, Settings.ctUiNext, l_actualControlType, m_player.lastGamepadType);

var l_pagesScale =  1.0 + smoothstep(m_anim_tab_flavor) * 0.04;
draw_sprite_ext(sui_book2Pages, 1, dx + kBookWidth * (1.0 - l_pagesScale) * 0.5, dy, l_pagesScale, 1.0, 0.0, c_white, 1.0);


// main menu
if (m_tab == BookTabs.Main)
{
	draw_sprite_ext(sui_book2Pages, 2, dx, dy, 1, 1, 0, c_white, 0.5);
	draw_sprite_ext(sui_book2Pages, 2, dx + kBookWidth, dy, -1, 1, 0, c_white, 0.5);
	
	// WAIT SECTION
	{
		draw_set_font(global.font_will14);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_color(c_bookHeadingShadow);
		draw_text_spaced(dx + kXOffsetCenterLeft, dy + 30 + 1, "WAIT", 2);
		draw_set_color(c_bookHeading);
		draw_text_spaced(dx + kXOffsetCenterLeft, dy + 30    , "WAIT", 2);
		
		var left = kXOffsetCenterLeft - 85;
		var right = kXOffsetCenterLeft + 85;
		var dy_rest0 = 70;
		var dy_rest1 = 150;
		
		draw_set_font(global.font_arvo7);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_spaced(dx + left + 6, dy + dy_rest0 - 18, "Progress is not saved when waiting.", 2);

		if (m_top_hover == BookSelects.RestShort || m_top_selection == BookSelects.RestShort)
		{
			draw_set_color((m_top_selection == BookSelects.RestShort) ? c_gold : c_white);
			draw_set_alpha((m_top_selection == BookSelects.RestShort) ? 1.0 : _playeruiBookAlphaPulse());
			draw_rectangle(dx + left - 1, dy + dy_rest0 - 1, dx + right + 1, dy + dy_rest0 + 16 + 1, false);
			draw_set_alpha(1.0);
		}
		draw_set_color(c_bookHeadingShadow);
		draw_rectangle(dx + left, dy + dy_rest0, dx + right, dy + dy_rest0 + 16, false);
		draw_set_color(c_black);
		draw_set_font(global.font_arvo9);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_spaced(dx + left + 6, dy + dy_rest0 + 1, "Wait for short time", 2);
		draw_sprite_ext(sui_book2TapeCorner, 0, dx + left, dy + dy_rest0, 1, 1, 0, c_white, 1.0);
		draw_sprite_ext(sui_book2TapeCorner, 2, dx + right + 1, dy + dy_rest0 + 16 + 1, 1, 1, 180, c_white, 1.0);
		m_hover_rects[BookSelects.RestShort] = [dx + left, dy + dy_rest0, dx + right, dy + dy_rest0 + 16];
		
		/*
		if (m_top_hover == BookSelects.RestFull || m_top_selection == BookSelects.RestFull)
		{
			draw_set_color((m_top_selection == BookSelects.RestFull) ? c_gold : c_white);
			draw_set_alpha((m_top_selection == BookSelects.RestFull) ? 1.0 : _playeruiBookAlphaPulse());
			draw_rectangle(dx + left - 1, dy + dy_rest1 - 1, dx + right + 1, dy + dy_rest1 + 16 + 1, false);
			draw_set_alpha(1.0);
		}
		draw_set_color(c_bookHeadingShadow);
		draw_rectangle(dx + left, dy + dy_rest1, dx + right, dy + dy_rest1 + 16, false);
		draw_set_color(c_black);
		draw_set_font(global.font_arvo9);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_spaced(dx + left + 6, dy + dy_rest1 + 1, "Camp until Sunrise", 2);
		draw_sprite_ext(sui_book2TapeCorner, 2, dx + left, dy + dy_rest1, 1, 1, 0, c_white, 1.0);
		draw_sprite_ext(sui_book2TapeCorner, 1, dx + right + 1, dy + dy_rest1, 1, 1, 270, c_white, 1.0);
		*/
		
		// OPTIONS FOR SHORT WAIT
		{
			var draw_alpha = (m_book_state == BookState.SelectionOptions && m_top_selection == BookSelects.RestShort) ? 1.0 : 0.5;
			draw_set_alpha(draw_alpha);
			
			if (m_sub_hover == BookSelects.RestShort_Duration || m_sub_selection == BookSelects.RestShort_Duration)
			{
				draw_set_color((m_sub_selection == BookSelects.RestShort_Duration) ? c_gold : c_white);
				draw_set_alpha((m_sub_selection == BookSelects.RestShort_Duration) ? 1.0 : _playeruiBookAlphaPulse());
				if (m_tri_hover < 0)
				{
					draw_rectangle_color(
						dx + left, dy + dy_rest0 + 16 + 8, dx + kXOffsetCenterLeft - 4, dy + dy_rest1 - 8,
						c_white, c_white,
						c_gold, c_gold,
						true);
				}
				else if (m_tri_hover > 0)
				{
					draw_rectangle_color(
						dx + left, dy + dy_rest0 + 16 + 8, dx + kXOffsetCenterLeft - 4, dy + dy_rest1 - 8,
						c_gold, c_gold,
						c_white, c_white,
						true);
				}
				else
				{
					draw_rectangle(dx + left - 1, dy + dy_rest0 + 16 + 8 - 1, dx + kXOffsetCenterLeft - 4 + 1, dy + dy_rest1 - 8 + 1, false);
				}
				draw_set_alpha(draw_alpha);
			}
			draw_set_color(c_bookHeadingShadow);
			draw_rectangle(dx + left, dy + dy_rest0 + 16 + 8, dx + kXOffsetCenterLeft - 4, dy + dy_rest1 - 8, false);
			draw_sprite_ext(sui_book2TapeCorner, 1, dx + left, dy + dy_rest0 + 16 + 8, 1, 1, 0, c_white, draw_alpha);
			draw_sprite_ext(sui_book2TapeCorner, 0, dx + kXOffsetCenterLeft - 4 + 1, dy + dy_rest1 - 8 + 1, 1, 1, 180, c_white, draw_alpha);
			draw_set_color((m_book_state == BookState.SelectionOptions && m_top_selection == BookSelects.RestShort) ? c_black : c_bookHeading);
			draw_set_font(global.font_arvo8);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_text_spaced(dx + (left + kXOffsetCenterLeft - 4) * 0.5, dy + (dy_rest0 + 16 + dy_rest1) * 0.5 - 8, string(m_option_current_waittime) + " Hours", 2);
			draw_arrow(dx + (left + kXOffsetCenterLeft - 4) * 0.5, dy + (dy_rest0 + 16 + dy_rest1) * 0.5 - 10,
					   dx + (left + kXOffsetCenterLeft - 4) * 0.5, dy + (dy_rest0 + 16 + dy_rest1) * 0.5 - 20, 9);
			draw_arrow(dx + (left + kXOffsetCenterLeft - 4) * 0.5, dy + (dy_rest0 + 16 + dy_rest1) * 0.5 + 10,
					   dx + (left + kXOffsetCenterLeft - 4) * 0.5, dy + (dy_rest0 + 16 + dy_rest1) * 0.5 + 20, 9);
			m_hover_rects[BookSelects.RestShort_Duration] = [dx + left, dy + dy_rest0 + 16 + 8, dx + kXOffsetCenterLeft - 4, dy + dy_rest1 - 8];

			if (m_sub_hover == BookSelects.RestShort_Confirm || m_sub_selection == BookSelects.RestShort_Confirm)
			{
				draw_set_color((m_sub_selection == BookSelects.RestShort_Confirm) ? c_gold : c_white);
				draw_set_alpha((m_sub_selection == BookSelects.RestShort_Confirm) ? 1.0 : _playeruiBookAlphaPulse());
				draw_rectangle(dx + kXOffsetCenterLeft + 4 - 1, dy + dy_rest0 + 16 + 8 - 1, dx + right + 1, dy + dy_rest1 - 8 + 1, false);
				draw_set_alpha(draw_alpha);
			}
			draw_set_color(c_bookHeadingShadow);
			draw_rectangle(dx + kXOffsetCenterLeft + 4, dy + dy_rest0 + 16 + 8, dx + right, dy + dy_rest1 - 8, false);
			draw_sprite_ext(sui_book2TapeCorner, 1, dx + kXOffsetCenterLeft + 4, dy + dy_rest0 + 16 + 8, 1, 1, 0, c_white, draw_alpha);
			draw_sprite_ext(sui_book2TapeCorner, 2, dx + right + 1, dy + dy_rest0 + 16 + 8, 1, 1, 270, c_white, draw_alpha);
			draw_set_color((m_book_state == BookState.SelectionOptions && m_top_selection == BookSelects.RestShort) ? c_black : c_bookHeading);
			draw_set_font(global.font_arvo8);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_text_spaced(dx + (kXOffsetCenterLeft + 4 + right) * 0.5, dy + (dy_rest0 + 16 + dy_rest1) * 0.5 - 8, "Wait Now", 2);
			m_hover_rects[BookSelects.RestShort_Confirm] = [dx + kXOffsetCenterLeft + 4, dy + dy_rest0 + 16 + 8, dx + right, dy + dy_rest1 - 8];
			
			draw_set_alpha(1.0);
		}
		
		// OPTIONS FOR SUNRISE REST
		/*
		{
			var draw_alpha = (m_book_state == BookState.SelectionOptions && m_top_selection == BookSelects.RestFull) ? 1.0 : 0.5;
			draw_set_alpha(draw_alpha);
			
			var wait_hours = 6.0 - timeofdayGetHour();
			if (wait_hours < 0)
				wait_hours += 24.0;
			
			if (m_sub_hover == BookSelects.RestFull || m_sub_selection == BookSelects.RestFull)
			{
				draw_set_color((m_sub_selection == BookSelects.RestFull) ? c_gold : c_white);
				draw_set_alpha((m_sub_selection == BookSelects.RestFull) ? 1.0 : _playeruiBookAlphaPulse());
				draw_rectangle(dx + left - 1, dy + dy_rest1 + 16 + 8 - 1, dx + right + 1, dy + dy_rest1 + 16 + 8 + 40 + 1, false);
				draw_set_alpha(draw_alpha);
			}
			draw_set_color(c_bookHeadingShadow);
			draw_rectangle(dx + left, dy + dy_rest1 + 16 + 8, dx + right, dy + dy_rest1 + 16 + 8 + 40, false);
			draw_sprite_ext(sui_book2TapeCorner, 1, dx + left, dy + dy_rest1 + 16 + 8 + 40 + 1, 1, 1, 90, c_white, draw_alpha);
			draw_sprite_ext(sui_book2TapeCorner, 2, dx + right + 1, dy + dy_rest1 + 16 + 8, 1, 1, 270, c_white, draw_alpha);
			draw_set_color((m_book_state == BookState.SelectionOptions && m_top_selection == BookSelects.RestShort) ? c_black : c_bookHeading);
			draw_set_font(global.font_arvo8);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_text_spaced(dx + kXOffsetCenterLeft, dy + dy_rest1 + 16 + 8 + 20 - 8, "Rest for " + string(round(wait_hours)) + " hours", 2);
			
			draw_set_alpha(1.0);
			
			draw_set_alpha(1.0);
		}
		*/
	}
	
	// WAIT SECTION
	{
		draw_set_font(global.font_will14);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_color(c_bookHeadingShadow);
		draw_text_spaced(dx + kXOffsetCenterLeft, dy + 150 + 1, "SYSTEM", 2);
		draw_set_color(c_bookHeading);
		draw_text_spaced(dx + kXOffsetCenterLeft, dy + 150    , "SYSTEM", 2);
		
		var left = kXOffsetCenterLeft - 85;
		var right = kXOffsetCenterLeft + 85;
		var dy_rest0 = 170 + 18;

		draw_set_font(global.font_arvo7);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_spaced(dx + left + 6, dy + dy_rest0 - 18, "Game is not saved when quitting.", 2);
		
		if (m_top_hover == BookSelects.QuitToMenu || m_top_selection == BookSelects.QuitToMenu)
		{
			draw_set_color((m_top_selection == BookSelects.QuitToMenu) ? c_gold : c_white);
			draw_set_alpha((m_top_selection == BookSelects.QuitToMenu) ? 1.0 : _playeruiBookAlphaPulse());
			draw_rectangle(dx + left - 1, dy + dy_rest0 - 1, dx + right + 1, dy + dy_rest0 + 16 + 1, false);
			draw_set_alpha(1.0);
		}
		draw_set_color(c_bookHeadingShadow);
		draw_rectangle(dx + left, dy + dy_rest0, dx + right, dy + dy_rest0 + 16, false);
		draw_set_color(c_black);
		draw_set_font(global.font_arvo9);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_spaced(dx + left + 6, dy + dy_rest0 + 1, "Return to menu.", 2);
		draw_sprite_ext(sui_book2TapeCorner, 1, dx + left, dy + dy_rest0, 1, 1, 0, c_white, 1.0);
		draw_sprite_ext(sui_book2TapeCorner, 0, dx + right + 1, dy + dy_rest0 + 16 + 1, 1, 1, 180, c_white, 1.0);
		m_hover_rects[BookSelects.QuitToMenu] = [dx + left, dy + dy_rest0, dx + right, dy + dy_rest0 + 16];
	}
	
	// RUNE SECTION
	{
		draw_set_font(global.font_will14);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_color(c_bookHeadingShadow);
		draw_text_spaced(dx + kXOffsetCenterRight, dy + 30 + 1, "????", 2);
		draw_set_color(c_bookHeading);
		draw_text_spaced(dx + kXOffsetCenterRight, dy + 30    , "????", 2);

		for (var i = 0; i < 6; ++i)
		{
			draw_sprite(sui_bookRuneSlot, 0,
						dx + kXOffsetCenterRight - 40 + 40 * (i % 3),
						dy + 90 + 50 * floor(i / 3));
			draw_sprite(sui_bookRuneSlot, 1,
						dx + kXOffsetCenterRight - 40 + 40 * (i % 3),
						dy + 90 + 50 * floor(i / 3));
		}
	}
}
else if (m_tab == BookTabs.Options)
{
	draw_sprite_ext(sui_book2Pages, 2, dx, dy, 1, 1, 0, c_white, 0.5);
	
	draw_set_font(global.font_will14);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(c_bookHeadingShadow);
	draw_text_spaced(dx + kXOffsetCenterLeft, dy + 18 + 1, "OPTIONS", 2);
	draw_set_color(c_bookHeading);
	draw_text_spaced(dx + kXOffsetCenterLeft, dy + 18    , "OPTIONS", 2);
	
	var left = kXOffsetCenterLeft - 85;
	var right = kXOffsetCenterLeft + 85;
	/*var dy_rest0 = 70;
	var dy_rest1 = 150;*/
	var dy_start = 50;
	var dy_div = 16 + 8;

	// Draw all the option categories:
	for (var i = 0; i < array_length_1d(m_options_top_choices); ++i)
	{
		if (m_top_hover == i + BookSelects.OptionBase || m_top_selection == i + BookSelects.OptionBase)
		{
			draw_set_color((m_top_selection == i + BookSelects.OptionBase) ? c_gold : c_white);
			draw_set_alpha((m_top_selection == i + BookSelects.OptionBase) ? 1.0 : _playeruiBookAlphaPulse());
			draw_rectangle(dx + left - 1, dy + dy_start + dy_div * i - 1, dx + right + 1, dy + dy_start + dy_div * i + 16 + 1, false);
			draw_set_alpha(1.0);
		}
		draw_set_color(c_bookHeadingShadow);
		draw_rectangle(dx + left, dy + dy_start + dy_div * i, dx + right, dy + dy_start + dy_div * i + 16, false);
		draw_set_color(c_black);
		draw_set_font(global.font_arvo9);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_spaced(dx + left + 6, dy + dy_start + dy_div * i + 1, m_options_top_choices[i], 2);
		draw_sprite_ext(sui_book2TapeCorner, 2, dx + left, dy + dy_start + dy_div * i, 1, 1, 0, c_white, 1.0);
		draw_sprite_ext(sui_book2TapeCorner, 1, dx + right + 1, dy + dy_start + dy_div * i, 1, 1, 270, c_white, 1.0);
		
		m_hover_rects[i + BookSelects.OptionBase] = [dx + left, dy + dy_start + dy_div * i, dx + right, dy + dy_start + dy_div * i + 16];
	}
	
	var op_dy_start = 20;
	var op_dy_div = 16 + 4;
	var op_left  = kXOffsetCenterRight - 85 - (kBookWidth/2);
	var op_right = kXOffsetCenterRight + 85 - (kBookWidth/2);
	var op_top_margin = 3;
	var op_surface_x = dx + kBookWidth / 2;
	var op_surface_y = dy + op_dy_start - op_top_margin;
	
	// Draw the options to a surface
	var buffer_drawOptions = surface_create(floor(kBookWidth / 2), floor(kBookHeight - op_dy_start * 2.0 - 24));
	surface_set_target(buffer_drawOptions);
	draw_clear_alpha(c_black, 0.0);
	
	var m_option_current = m_option_current_choice;
	var l_drawingOptions = false;
	var l_ddy = op_top_margin - m_sub_scroll;
	for (var i = 0; i < array_length_1d(m_options); ++i)
	{
		var l_current_option = m_options[i];
		
		// Reset selection box
		m_hover_rects[i + BookSelects.Option_OptionBase] = null;
		
		// option data:
		//	[0] - category
		//	[1] - type
		//	[2] - display name
		//	[3] - key name
		
		// dont start until on right option type, and stop when done with it
		if (!l_drawingOptions && l_current_option[0] == m_option_current)
			l_drawingOptions = true;
		else if (!l_drawingOptions && l_current_option[0] != m_option_current)
			continue;
		else if (l_drawingOptions && l_current_option[0] != m_option_current)
			break;
			
		// Check the option type:
		if (l_current_option[1] == kOptionEntryHeading)
		{
			// Draw heading
			draw_set_color(c_black);
			draw_set_font(global.font_arvo9);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_text_spaced(op_left + 2, l_ddy + 1, l_current_option[2], 2); 
			
			l_ddy += op_dy_div + 4;
		}
		else if (l_current_option[1] == kOptionEntryOption)
		{
			// TODO: Skip drawing if not in view
			
			// Draw the hover rect
			if (m_sub_hover == i + BookSelects.Option_OptionBase || m_sub_selection == i + BookSelects.Option_OptionBase)
			{
				draw_set_color((m_sub_selection == i + BookSelects.Option_OptionBase) ? c_gold : c_white);
				draw_set_alpha((m_sub_selection == i + BookSelects.Option_OptionBase) ? 1.0 : _playeruiBookAlphaPulse());
				draw_rectangle(op_left - 1, l_ddy - 1, op_right + 1, l_ddy + 16 + 1, false);
				draw_set_alpha(1.0);
			}
			// draw the bg rect
			draw_set_color(c_bookHeadingShadow);
			draw_rectangle(op_left, l_ddy, op_right, l_ddy + 16, false);
			draw_set_color(c_black);
			// draw the option name
			draw_set_font(global.font_arvo7);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_text_spaced(op_left + 2, l_ddy + 2, l_current_option[2], 2);
			
			// draw the current value
			switch (ssettingGetType(l_current_option[3]))
			{
				case kSettingTypeControl:
				{
					var setting = controlSettingGet(l_current_option[3]);
					var control_x_base = round(lerp(op_left, op_right, 0.52)) + 3;
					//drawControl((op_left + op_right) / 2 + 8, l_ddy + 8, null, kControlDrawStyle_Flat, setting, kControlKB, kGamepadTypeXInput);
					for (var isetting = 0; isetting < 8; isetting += 2)
					{
						// draw the select box for the sub-sub-option
						if (m_sub_hover == i + BookSelects.Option_OptionBase || m_sub_selection == i + BookSelects.Option_OptionBase)
						{
							if (m_tri_hover == floor(isetting / 2))
							{
								draw_set_color((m_tri_selection == floor(isetting / 2)) ? c_gold : c_white);
								draw_set_alpha((m_tri_selection == floor(isetting / 2)) ? 1.0 : _playeruiBookAlphaPulse());
								draw_rectangle( control_x_base + isetting * 11.5 - 11, l_ddy + 0,
												control_x_base + isetting * 11.5 + 10, l_ddy + 16, false);
								draw_set_alpha(1.0);
							}
						}
						
						var setting_group;
						if (isetting < array_length_1d(setting))
							setting_group = [setting[isetting], setting[isetting + 1]];
						else
							setting_group = [null, null];
							
						drawControl(control_x_base + isetting * 11.5,
									l_ddy + 8,
									null,
									kControlDrawStyle_Skeuo,
									setting_group, setting_group[0],
									kGamepadTypeXInput);
									
						if (isetting < 6)
						{
							draw_set_color(c_bookHeading);
							draw_line(control_x_base + isetting * 11.5 + 11, l_ddy + 0,
									  control_x_base + isetting * 11.5 + 11, l_ddy + 15);
						}
						
						// set up the UI boxes
						if (m_sub_hover == i + BookSelects.Option_OptionBase || m_sub_selection == i + BookSelects.Option_OptionBase)
						{
							m_hover_rects[floor(isetting / 2) + BookSelects.Option_TriOptionBase] =
								[op_surface_x + control_x_base + isetting * 11.5 - 11,  op_surface_y + l_ddy + 0,
								 op_surface_x + control_x_base + isetting * 11.5 + 10,  op_surface_y + l_ddy + 16];
						}
					}
				} break;
				
				case kSettingTypeFloat:
				{
					draw_set_font(global.font_arvo9Bold);
					var float_center = round(lerp(op_left, op_right, 0.75));
					var float_value = ssettingGetValue(l_current_option[3]);
					draw_set_halign(fa_center);
					draw_text_spaced(float_center, 
									 l_ddy + 1,
									 string_format(float_value, 2, 1),
									 2);
									 
					draw_set_color(float_value < ssettingGetMax(l_current_option[3]) ? c_black : c_bookHeading);
					draw_arrow(float_center + 16, l_ddy + 7.5, float_center + 23, l_ddy + 7.5, 9);
					draw_set_color(float_value > ssettingGetMin(l_current_option[3]) ? c_black : c_bookHeading);
					draw_arrow(float_center - 16, l_ddy + 7.5, float_center - 23, l_ddy + 7.5, 9);
				} break;
				
				case kSettingTypeEnum:
				{
					draw_set_font(global.font_arvo9);
					var enum_center = round(lerp(op_left, op_right, 0.67));
					var enum_value = ssettingGetValue(l_current_option[3]);
					draw_text_spaced(enum_center, 
									 l_ddy + 1,
									 ssettingGetEnumName(l_current_option[3], enum_value),
									 2);
					
					draw_set_color(enum_value < ssettingGetMax(l_current_option[3]) ? c_black : c_bookHeading);
					draw_arrow(enum_center + 0 + 46, l_ddy + 7.5, enum_center + 0 + 53, l_ddy + 7.5, 9);
					draw_set_color(enum_value > ssettingGetMin(l_current_option[3]) ? c_black : c_bookHeading);
					draw_arrow(enum_center + 3 - 6, l_ddy + 7.5, enum_center + 3 - 13, l_ddy + 7.5, 9);
				} break;
				
				case kSettingTypeBoolean:
				{
					var box_center = round(lerp(op_left, op_right, 0.75));
					draw_rectangle(box_center - 6, l_ddy + 2, box_center + 6, l_ddy + 2 + 12, true);
					if (ssettingGetValue(l_current_option[3]))
					{
						draw_line(box_center + 8, l_ddy, box_center - 2, l_ddy + 2 + 10);
						draw_line(box_center - 5, l_ddy + 7, box_center - 2, l_ddy + 2 + 10);
					}
				} break;
			}
			
			m_hover_rects[i + BookSelects.Option_OptionBase] = [op_surface_x + op_left, op_surface_y + l_ddy, op_surface_x + op_right, op_surface_y + l_ddy + 16];
			
			l_ddy += op_dy_div;
		}
	}
	
	// draw arrows on the right
	draw_set_color(c_black);
	draw_arrow(op_right + 8.5, op_top_margin + 10,
				op_right + 8.5, op_top_margin, 9);
	m_hover_rects[BookSelects.Option_ViewUp]   = [op_surface_x + op_right, op_surface_y + op_top_margin, op_surface_x + op_right + 16, op_surface_y + op_top_margin + 10];
	draw_arrow(op_right + 8.5, surface_get_height(buffer_drawOptions) - op_top_margin - 10,
				op_right + 8.5, surface_get_height(buffer_drawOptions) - op_top_margin, 9);
	m_hover_rects[BookSelects.Option_ViewDown] = [op_surface_x + op_right, op_surface_y + surface_get_height(buffer_drawOptions) - op_top_margin - 10, op_surface_x + op_right + 16, op_surface_y + surface_get_height(buffer_drawOptions) - op_top_margin];
	
	surface_reset_target();
	draw_surface(buffer_drawOptions, op_surface_x, op_surface_y);
	surface_free(buffer_drawOptions);
}
else if (m_tab == BookTabs.Relationship)
{
	draw_sprite_ext(sui_book2Pages, 2, dx + kBookWidth, dy, -1, 1, 0, c_white, 0.5);
	
	draw_set_font(global.font_will14);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(c_bookHeadingShadow);
	draw_text_spaced(dx + kXOffsetCenterLeft, dy + 18 + 1, "PEOPLE", 2);
	draw_set_color(c_bookHeading);
	draw_text_spaced(dx + kXOffsetCenterLeft, dy + 18    , "PEOPLE", 2);
}
else if (m_tab == BookTabs.Map)
{
	draw_set_font(global.font_will14);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(c_bookHeadingShadow);
	draw_text_spaced(dx + kXOffsetCenterLeft, dy + 18 + 1, "MAP", 2);
	draw_set_color(c_bookHeading);
	draw_text_spaced(dx + kXOffsetCenterLeft, dy + 18    , "MAP", 2);
	
	var map = o_PlayerHud.map;
	
	if (room > 0 && room < array_length_1d(map.rooms_info))
	{
		var ddx = dx + kXOffsetCenterRight;
		var ddy = dy + kBookHeight * 0.5;
	
		// get center of map
		var room_info = map.rooms_info[room];
		var room_info_min = room_info[0];
		var room_info_max = room_info[1];
		var room_info_center = [
			(room_info_min[0] + room_info_max[0]) * 0.5, 
			(room_info_min[1] + room_info_min[1]) * 0.5
			];
		
		// get position of player
		var pl_pos_percent = [
			m_player.x / room_width,
			m_player.y / room_height
			];
		var pl_pos_grid = [
			room_info_min[0] + (room_info_max[0] - room_info_min[0]) * pl_pos_percent[0],
			room_info_min[1] + (room_info_max[1] - room_info_min[1]) * pl_pos_percent[1]
			];
		
		// select the map bounds from the center
		var kHalfDiv = 5.0;
		var map_start = [
			round(room_info_center[0] - kHalfDiv),
			round(room_info_center[1] - kHalfDiv)
			];
		var map_end = [
			map_start[0] + kHalfDiv * 2.0,
			map_start[1] + kHalfDiv * 2.0
			];
		var map_center = [
			(map_start[0] + map_end[0]) * 0.5,
			(map_start[1] + map_end[1]) * 0.5
			];
		
		// grid constants
		var kGridW = 10.0;
		
		// draw the map from the bounds
		for (var ix = map_start[0]; ix <= map_end[0]; ++ix)
		{
			for (var iy = map_start[1]; iy <= map_end[1]; ++iy)
			{
				var v_ix = ix - map_center[0];
				var v_iy = iy - map_center[1];
			
				var room_id = map.map[ix + iy * map.map_width];
				if (room_id != null)
				{
					draw_set_alpha(0.5);
					draw_set_color(merge_color(c_gold, c_dkgray, 0.5));
					draw_rectangle(
						ddx +  v_ix      * kGridW, ddy +  v_iy      * kGridW,
						ddx + (v_ix + 1) * kGridW, ddy + (v_iy + 1) * kGridW,
						false);
					
					var local_room_info = map.rooms_info[room_id];
					var local_room_info_min = local_room_info[0];
					var local_room_info_max = local_room_info[1];
					draw_set_color(c_bookHeading);
					draw_set_alpha(1.0);
					draw_rectangle(
						ddx + (local_room_info_min[0] - map_center[0]) * kGridW,
						ddy + (local_room_info_min[1] - map_center[1]) * kGridW,
						ddx + (local_room_info_max[0] - map_center[0]) * kGridW,
						ddy + (local_room_info_max[1] - map_center[1]) * kGridW,
						true);
				}
			}
		}
	
		// draw the curret room
		draw_set_color(c_white);
		draw_set_alpha(1.0);
		draw_rectangle(
			ddx + (room_info_min[0] - map_center[0]) * kGridW,
			ddy + (room_info_min[1] - map_center[1]) * kGridW,
			ddx + (room_info_max[0] - map_center[0]) * kGridW,
			ddy + (room_info_max[1] - map_center[1]) * kGridW,
			true
			);
	
		// todo: draw the current subroom
	
		// draw player position
		draw_set_color(c_red);
		draw_circle(
			ddx + (pl_pos_grid[0] - map_center[0]) * kGridW,
			ddy + (pl_pos_grid[1] - map_center[1]) * kGridW,
			2, false);
	}
}

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_color(c_black);
draw_set_alpha(1.0);
//draw_set_font(f_josefinSlab9);

/*draw_text(dx + 24, dy + 30, "I should make camp.");
draw_text(dx + 24, dy + 50, "Time for a journal entry.");
draw_text(dx + 24, dy + 70, "Options");
draw_text(dx + 24, dy + 90, "Quicksave and Quit");
*/

// Go back to normal blendmode
gpu_set_blendmode(bm_normal);