if (m_book_totalBlend <= 0.01) exit;

surface_reset_target();
surface_set_target(m_surface);

var c_bookHeading = make_color_rgb(165, 98, 67);
var c_bookHeadingShadow = make_color_rgb(207, 182, 144);

var kBookWidth = 482;
var kBookHeight = 298;

var dx, dy;
dx = ((Screen.width / Screen.pixelScale) - kBookWidth) / 2;
dy = round(((Screen.height / Screen.pixelScale) - kBookHeight) * 1.0 - 16.0);
//dy += (1.0 - smoothstep(m_book_totalBlend)) * 316;
dy += sqr(1.0 - saturate(m_book_totalBlend)) * 316;

m_book_base_x = dx;
m_book_base_y = dy;

draw_sprite(sui_book2Pages, 0, dx, dy);

for (var i = 0; i < 4; ++i)
{
	var ddx = dx + 40 + 25 * i;
	var ddy = dy + 10 + round(sin(i * 2.11) * 1.49);
	draw_sprite(sui_bookTabs, i % 3, ddx, ddy);
	draw_sprite_ext(sui_bookTabIcons, i, ddx, ddy, 1, 1, 0, c_maroon, 1.0);
	
	if (m_book_tab == i)
	{
		draw_sprite(sui_bookTabIcons, i, ddx, ddy);
	}
}

// draw controls for the tabs
drawControl(dx + 40 - 25 * 1 + 3, dy - 10, null, kControlDrawStyle_Flat, Settings.ctUiPrevious, m_player.lastControlType, m_player.lastGamepadType);
drawControl(dx + 40 + 25 * 4 - 3, dy - 10, null, kControlDrawStyle_Flat, Settings.ctUiNext, m_player.lastControlType, m_player.lastGamepadType);

draw_sprite(sui_book2Pages, 1, dx, dy);


// main menu
if (m_book_tab == Tabs.kMain)
{
	draw_sprite(sui_book2Pages, 2, dx, dy);
	draw_sprite_ext(sui_book2Pages, 2, dx + kBookWidth, dy, -1, 1, 0, c_white, 1.0);
	
	// REST SECTION
	{
		draw_set_font(global.font_will14);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_color(c_bookHeadingShadow);
		draw_text_spaced(dx + 135, dy + 30 + 1, "REST", 2);
		draw_set_color(c_bookHeading);
		draw_text_spaced(dx + 135, dy + 30    , "REST", 2);

		draw_set_color(c_bookHeadingShadow);
		draw_rectangle(dx + 48, dy + 80, dx + 220, dy + 96, false);
		draw_set_color(c_black);
		draw_set_font(global.font_arvo9);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_spaced(dx + 48 + 4, dy + 80 + 1, "Camp for 3 Hours", 2);

		draw_set_color(c_bookHeadingShadow);
		draw_rectangle(dx + 48, dy + 110, dx + 220, dy + 126, false);
		draw_set_color(c_black);
		draw_set_font(global.font_arvo9);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_spaced(dx + 48 + 4, dy + 110 + 1, "Camp until Sunrise", 2);
	}
	
	// RUNE SECTION
	{
		draw_set_font(global.font_will14);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_color(c_bookHeadingShadow);
		draw_text_spaced(dx + kBookWidth - 135, dy + 30 + 1, "????", 2);
		draw_set_color(c_bookHeading);
		draw_text_spaced(dx + kBookWidth - 135, dy + 30    , "????", 2);

		for (var i = 0; i < 6; ++i)
		{
			draw_sprite(sui_bookRuneSlot, 0,
						dx + 350 - 40 + 40 * (i % 3),
						dy + 90 + 50 * floor(i / 3));
			draw_sprite(sui_bookRuneSlot, 1,
						dx + 350 - 40 + 40 * (i % 3),
						dy + 90 + 50 * floor(i / 3));
		}
	}
	// draw buttons
	/*for (var i = 0; i < ((m_book_main_selection == null) ? 5 : 7); ++i)
	{
		var offsets = m_book_offsets_main[i];
		var draw_x = dx + offsets[0];
		var draw_y = dy + offsets[1];
		
		// draw outline on hover
		if (m_book_main_hover == i)
		{
			draw_set_color(c_white);
			shader_set(sh_colormaskAlphatest);
			var color = merge_color(c_crystalblue, c_gold, sin(current_time * 0.01) * 0.5 + 0.5);
			color = merge_color(c_white, color, 0.75);
			draw_sprite_ext(sui_bookButtons2, i, draw_x - 1, draw_y, 1.0, 1.0, 0.0, color, 1.0);
			draw_sprite_ext(sui_bookButtons2, i, draw_x + 1, draw_y, 1.0, 1.0, 0.0, color, 1.0);
			draw_sprite_ext(sui_bookButtons2, i, draw_x, draw_y - 1, 1.0, 1.0, 0.0, color, 1.0);
			draw_sprite_ext(sui_bookButtons2, i, draw_x, draw_y + 1, 1.0, 1.0, 0.0, color, 1.0);
			shader_reset();
		}
		// draw white outline on selection
		if (m_book_main_selection == i)
		{
			draw_set_color(c_white);
			shader_set(sh_colormaskAlphatest);
			var color = c_white;
			draw_sprite_ext(sui_bookButtons2, i, draw_x - 1, draw_y, 1.0, 1.0, 0.0, color, 1.0);
			draw_sprite_ext(sui_bookButtons2, i, draw_x + 1, draw_y, 1.0, 1.0, 0.0, color, 1.0);
			draw_sprite_ext(sui_bookButtons2, i, draw_x, draw_y - 1, 1.0, 1.0, 0.0, color, 1.0);
			draw_sprite_ext(sui_bookButtons2, i, draw_x, draw_y + 1, 1.0, 1.0, 0.0, color, 1.0);
			shader_reset();
		}
		
		draw_sprite(sui_bookButtons2, i, draw_x, draw_y);
	}

	// draw area headings
	draw_sprite(sui_bookLabels, 0, dx + 74, dy + 20);
	draw_sprite(sui_bookLabels, 1, dx + 78, dy + 95);*/
}
else if (m_book_tab == Tabs.kOptions)
{
	draw_text( dx + 10, dy + 10, "oPtIoNs lel");
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
