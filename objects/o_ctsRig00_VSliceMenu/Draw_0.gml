/// @description Draw the vslice menu

if (image_alpha <= 0.0)
	exit;
	
draw_set_alpha(image_alpha);

// Draw title top
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(global.font_will14);

// Draw the menu items
for (var i = 0; i < array_length_1d(menuListing); ++i)
{
	var menuItem = menuListing[i];
	
	var dx = 28;
	var dy = 48 + i * 27;
	
	menuDrawRects[i] = [dx - 8, dy - 11, dx + 190, dy + 11];
	
	draw_set_color(c_black);
	draw_set_alpha(image_alpha * 0.5);
	draw_rectangle(dx - 8, dy - 11, dx + 190, dy + 11, false);
	
	// Do hover check
	if (m_menuHover == i)
	{
		draw_set_color(c_gold);
		draw_set_alpha(image_alpha);
		draw_rectangle(dx - 8, dy - 11, dx + 190, dy + 11, true);
	}
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_font(global.font_arvo9);
	draw_set_color(c_white);
	draw_set_alpha(image_alpha);
	draw_text_spaced(dx, dy, menuItem[kiVSliceMenuTitle], 3);
}

// Draw the description
if (m_menuDescriptionAlpha > 0.0 && m_menuDescriptionSelection != null)
{
	var menuItem = menuListing[m_menuDescriptionSelection];
	
	draw_set_alpha(image_alpha * m_menuDescriptionAlpha * 0.5);
	draw_set_color(c_black);
	draw_rectangle(240, 48, 240 + 300, 48 + 100, false);
	
	draw_set_alpha(image_alpha * m_menuDescriptionAlpha);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(global.font_arvo9);
	draw_set_color(c_white);
	draw_text_spaced_wrap(240 + 8, 48 + 8, menuItem[kiVSliceMenuDesc], 3, 300 - 16);
}

// Draw cursor at the mouse
draw_sprite(sui_cursor, 1, uPosition, vPosition);