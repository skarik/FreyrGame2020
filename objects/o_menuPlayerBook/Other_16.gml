/// @description Insert description here
// You can write your code in this editor

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
	
	// REST SECTION
	{
		draw_set_font(global.font_will14);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_color(c_bookHeadingShadow);
		draw_text_spaced(dx + kXOffsetCenterLeft, dy + 30 + 1, "REST", 2);
		draw_set_color(c_bookHeading);
		draw_text_spaced(dx + kXOffsetCenterLeft, dy + 30    , "REST", 2);
		
		var left = kXOffsetCenterLeft - 85;
		var right = kXOffsetCenterLeft + 85;
		var dy_rest0 = 70;
		var dy_rest1 = 150;
		
		draw_set_font(global.font_arvo7);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_spaced(dx + left + 6, dy + dy_rest0 - 18, "Progress is saved at each rest.", 2);

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
		draw_text_spaced(dx + left + 6, dy + dy_rest0 + 1, "Camp for short time", 2);
		draw_sprite_ext(sui_book2TapeCorner, 0, dx + left, dy + dy_rest0, 1, 1, 0, c_white, 1.0);
		draw_sprite_ext(sui_book2TapeCorner, 2, dx + right + 1, dy + dy_rest0 + 16 + 1, 1, 1, 180, c_white, 1.0);

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
		
		// OPTIONS FOR SHORT REST
		{
			var draw_alpha = (m_book_state == BookState.SelectionOptions && m_top_selection == BookSelects.RestShort) ? 1.0 : 0.5;
			draw_set_alpha(draw_alpha);
			
			if (m_sub_hover == BookSelects.RestFull || m_sub_selection == BookSelects.RestFull)
			{
				draw_set_color((m_sub_selection == BookSelects.RestFull) ? c_gold : c_white);
				draw_set_alpha((m_sub_selection == BookSelects.RestFull) ? 1.0 : _playeruiBookAlphaPulse());
				draw_rectangle(dx + left - 1, dy + dy_rest0 + 16 + 8 - 1, dx + kXOffsetCenterLeft - 4 + 1, dy + dy_rest1 - 8 + 1, false);
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
			draw_text_spaced(dx + (left + kXOffsetCenterLeft - 4) * 0.5, dy + (dy_rest0 + 16 + dy_rest1) * 0.5 - 8, "3 Hours", 2);
			draw_arrow(dx + (left + kXOffsetCenterLeft - 4) * 0.5, dy + (dy_rest0 + 16 + dy_rest1) * 0.5 - 10,
					   dx + (left + kXOffsetCenterLeft - 4) * 0.5, dy + (dy_rest0 + 16 + dy_rest1) * 0.5 - 20, 9);
			draw_arrow(dx + (left + kXOffsetCenterLeft - 4) * 0.5, dy + (dy_rest0 + 16 + dy_rest1) * 0.5 + 10,
					   dx + (left + kXOffsetCenterLeft - 4) * 0.5, dy + (dy_rest0 + 16 + dy_rest1) * 0.5 + 20, 9);

			if (m_sub_hover == BookSelects.RestFull || m_sub_selection == BookSelects.RestFull)
			{
				draw_set_color((m_sub_selection == BookSelects.RestFull) ? c_gold : c_white);
				draw_set_alpha((m_sub_selection == BookSelects.RestFull) ? 1.0 : _playeruiBookAlphaPulse());
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
			draw_text_spaced(dx + (kXOffsetCenterLeft + 4 + right) * 0.5, dy + (dy_rest0 + 16 + dy_rest1) * 0.5 - 8, "Rest Now", 2);
			
			draw_set_alpha(1.0);
		}
		
		// OPTIONS FOR SUNRISE REST
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
	
	for (var i = 0; i < array_length_1d(m_options_top_choices); ++i)
	{
		/*if (m_top_hover == BookSelects.RestFull || m_top_selection == BookSelects.RestFull)
		{
			draw_set_color((m_top_selection == BookSelects.RestFull) ? c_gold : c_white);
			draw_set_alpha((m_top_selection == BookSelects.RestFull) ? 1.0 : _playeruiBookAlphaPulse());
			draw_rectangle(dx + left - 1, dy + dy_rest1 - 1, dx + right + 1, dy + dy_rest1 + 16 + 1, false);
			draw_set_alpha(1.0);
		}*/
		draw_set_color(c_bookHeadingShadow);
		draw_rectangle(dx + left, dy + dy_start + dy_div * i, dx + right, dy + dy_start + dy_div * i + 16, false);
		draw_set_color(c_black);
		draw_set_font(global.font_arvo9);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_spaced(dx + left + 6, dy + dy_start + dy_div * i + 1, m_options_top_choices[i], 2);
		draw_sprite_ext(sui_book2TapeCorner, 2, dx + left, dy + dy_start + dy_div * i, 1, 1, 0, c_white, 1.0);
		draw_sprite_ext(sui_book2TapeCorner, 1, dx + right + 1, dy + dy_start + dy_div * i, 1, 1, 270, c_white, 1.0);
	}
	
	
	var op_dy_start = 20;
	var op_dy_div = 16 + 4;
	var op_left = kXOffsetCenterRight - 85;
	var op_right = kXOffsetCenterRight + 85;
	
	var m_option_current = kOptionTypeControls;
	var l_drawingOptions = false;
	var l_ddy = op_dy_start;
	for (var i = 0; i < array_length_1d(m_options); ++i)
	{
		var l_current_option = m_options[i];
		// dont start until on right option type, and stop when done with it
		if (!l_drawingOptions && l_current_option[0] == m_option_current)
			l_drawingOptions = true;
		else if (!l_drawingOptions && l_current_option[0] != m_option_current)
			continue;
		else if (l_drawingOptions && l_current_option[0] != m_option_current)
			break;
			
		// Draw the options
		
		if (l_current_option[1] == kOptionEntryHeading)
		{
			/*draw_set_color(c_bookHeadingShadow);
			draw_rectangle(dx + op_left, dy + dy_start + dy_div * i, dx + op_right, dy + dy_start + dy_div * i + 16, false);*/
			draw_set_color(c_black);
			draw_set_font(global.font_arvo9);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_text_spaced(dx + op_left + 6, dy + l_ddy + 1, l_current_option[2], 2);
			
			l_ddy += op_dy_div + 4;
		}
		else if (l_current_option[1] == kOptionEntryOption)
		{
			draw_set_color(c_bookHeadingShadow);
			draw_rectangle(dx + op_left, dy + l_ddy, dx + op_right, dy + l_ddy + 16, false);
			draw_set_color(c_black);
			draw_set_font(global.font_arvo7);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_text_spaced(dx + op_left + 6, dy + l_ddy + 1, l_current_option[2], 2);
			
			var setting = controlSettingGet(l_current_option[3]);
			if (is_array(setting))
			{
				drawControl(dx + kXOffsetCenterRight, dy + l_ddy, null, kControlDrawStyle_Flat, setting, kControlKB, kGamepadTypeXInput);
			}
			
			l_ddy += op_dy_div;
		}
	}
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