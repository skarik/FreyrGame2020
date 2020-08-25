/// @description Unified UI draw

/*var c_bookHeading = make_color_rgb(165, 98, 67);
var c_bookHeadingShadow = make_color_rgb(207, 182, 144);

var kBookWidth = 482;
var kBookHeight = 298;
var kXOffsetCenterLeft = 130;
var kXOffsetCenterRight = kBookWidth - 130;

var kTabStartX = 50;
var kTabDivX = 25;
var kTabStartY = 9;*/

var dx, dy;
/*dx = ((Screen.width / Screen.pixelScale) - kBookWidth) / 2;
dy = round(((Screen.height / Screen.pixelScale) - kBookHeight) * 1.0 - 16.0);
dy += sqr(1.0 - saturate(m_totalBlend)) * 316; // Slide the book in from the bottom*/

dx = GameCamera.width / 2;
dy = -GameCamera.height * sqr(1.0 - saturate(m_totalBlend));

m_base_x = dx;
m_base_y = dy;

// Disable alpha-channel blending for most of this.
gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one);

// draw character sprites
var l_player_portrait = cutsceneGetPortrait(o_PlayerTest, kPortraitExpressionNeutral);
var l_trader_portrait = m_vendorPortraitSprite;
draw_sprite_ext(l_player_portrait, 0,
				(1.0 - sqr(saturate(1.0 - m_totalBlend))) * sprite_get_width(l_player_portrait) - 60, GameCamera.height,
				-1.0, 1.0,
				0.0, c_white, 1.0);
if (sprite_exists(l_trader_portrait))
{
	draw_sprite_ext(l_trader_portrait, 0,
					(1.0 - sqr(saturate(1.0 - m_totalBlend))) * -sprite_get_width(l_trader_portrait) + 60 + GameCamera.width, GameCamera.height,
					+1.0, 1.0,
					0.0, c_white, 1.0);
}

// draw the left & right panels

var panel_x;
var panel_y;

// player on left
panel_x = dx - 170;
panel_y = dy + 130;
_playeruiVendorDrawItemBox(panel_x, panel_y, 100, 150, true, 4, 6, 1.0, m_player.inventory.bag, m_boxgs_player, m_boxds_player);
draw_set_color(c_white);
draw_set_font(global.font_will14);
draw_set_halign(fa_middle);
draw_set_valign(fa_bottom);
draw_text_spaced(panel_x, panel_y - 5, "BAG", 4);

// vendor on right
panel_x = dx + 170;
panel_y = dy + 130;
_playeruiVendorDrawItemBox(panel_x, panel_y, 100, 150, true, 4, 6, 1.0, m_vendor.m_inventory.item, m_boxgs_vendor, m_boxds_vendor);
draw_set_color(c_white);
draw_set_font(global.font_will14);
draw_set_halign(fa_middle);
draw_set_valign(fa_bottom);
draw_text_spaced(panel_x, panel_y - 5, "AVAILABLE", 4);

// center (give & take)
panel_x = dx;
panel_y = dy + GameCamera.height / 2 - 50 + 30;
_playeruiVendorDrawItemBox(panel_x + 65, panel_y, 100, 100, false, 4, 4, 1.0, m_itemarray_rx, m_boxgs_rx, m_boxds_rx);
_playeruiVendorDrawItemBox(panel_x - 65, panel_y, 100, 100, false, 4, 4, 1.0, m_itemarray_tx, m_boxgs_tx, m_boxds_tx);
draw_set_color(c_white);
draw_set_font(global.font_will14);
draw_set_halign(fa_middle);
draw_set_valign(fa_bottom);
draw_text_spaced(panel_x + 65 + 24, panel_y - 5, "GET", 4);
draw_text_spaced(panel_x - 65 - 24, panel_y - 5, "GIVE", 4);

panel_x = dx;
panel_y = dy + GameCamera.height / 2 + 30;
//draw_set_color(c_gold);
//draw_rectangle(panel_x - 10, panel_y - 40, panel_x + 9, panel_y + 40, false);
draw_9slice_flex(panel_x - 12, panel_y - 46, 24, 92, sui_vendor_button, 1, 7, 15);
m_buttonds[?VendorButtons.Trade] = [panel_x - 12, panel_y - 46, 24, 92];
if (m_tradeenabled)
	draw_set_color((m_buttongs[?"hover"] == VendorButtons.Trade) ? c_gold : c_uigold);
else
	draw_set_color(c_black);
draw_set_font(global.font_will14);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
//draw_text_spaced(panel_x, panel_y, "TRADE", 2);
draw_text(panel_x - 1, panel_y, "T\nR\nA\nD\nE");

// draw buttons
panel_x = dx - 65;
panel_y = dy + GameCamera.height / 2 + 94;
draw_9slice_flex(panel_x - 24, panel_y - 10, 48, 20, sui_vendor_button, 1, 7, 10);
m_buttonds[?VendorButtons.ClearGive] = [panel_x - 24, panel_y - 10, 48, 20];
draw_set_color((m_buttongs[?"hover"] == VendorButtons.ClearGive) ? c_gold : c_uigold);
draw_set_font(global.font_arvo9Bold);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_spaced(panel_x, panel_y, "Clear", 2);

panel_x = dx + 65;
panel_y = dy + GameCamera.height / 2 + 94;
draw_9slice_flex(panel_x - 24, panel_y - 10, 48, 20, sui_vendor_button, 1, 7, 10);
m_buttonds[?VendorButtons.ClearGet] = [panel_x - 24, panel_y - 10, 48, 20];
draw_set_color((m_buttongs[?"hover"] == VendorButtons.ClearGet) ? c_gold : c_uigold);
draw_set_font(global.font_arvo9Bold);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_spaced(panel_x, panel_y, "Clear", 2);

panel_x = dx;
panel_y = dy + GameCamera.height / 2 + 94;
draw_9slice_flex(panel_x - 24, panel_y - 10, 48, 20, sui_vendor_button, 0, 7, 10);
m_buttonds[?VendorButtons.Leave] = [panel_x - 24, panel_y - 10, 48, 20];
draw_set_color((m_buttongs[?"hover"] == VendorButtons.Leave) ? c_gold : c_uigold);
draw_set_font(global.font_arvo9Bold);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_spaced(panel_x, panel_y, "Leave", 2);

// favor indicator
panel_x = dx;
panel_y = dy + GameCamera.height / 2 - 50 + 30 - 40;
draw_9slice_flex(panel_x - 55, panel_y, 110, 37, sui_vendor_button, 1, 7, 15);
draw_set_color(c_ltgray);
draw_set_font(global.font_arvo8);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text_spaced(panel_x, panel_y + 2, "Favors", 2);
draw_set_valign(fa_middle);
draw_set_font(global.font_arvo6Bold);
draw_text_spaced(panel_x - 35, panel_y + 18, "Loss", 2);
draw_text_spaced(panel_x +  0, panel_y + 18, "Fair", 2);
draw_text_spaced(panel_x + 35, panel_y + 18, "Gift", 2);
draw_line(panel_x - 35, panel_y + 23, panel_x - 35, panel_y + 31);
draw_line(panel_x -  7, panel_y + 23, panel_x -  7, panel_y + 31);
draw_line(panel_x +  0, panel_y + 23, panel_x +  0, panel_y + 31);
draw_line(panel_x + 35, panel_y + 23, panel_x + 35, panel_y + 31);
// draw favor line
draw_sprite(sui_arcaneSelect, 2, panel_x + 35 * -m_tradebalance_visual, panel_y + 18);

// item overlay at end
if (m_held_inventory[0].object == null)
{
	_playeruiVendorDrawItemBoxOverlay(m_player.inventory.bag, m_boxgs_player, m_boxds_player);
	_playeruiVendorDrawItemBoxOverlay(m_vendor.m_inventory.item, m_boxgs_vendor, m_boxds_vendor);
	_playeruiVendorDrawItemBoxOverlay(m_itemarray_rx, m_boxgs_rx, m_boxds_rx);
	_playeruiVendorDrawItemBoxOverlay(m_itemarray_tx, m_boxgs_tx, m_boxds_tx);
}
else
{
	dx = round(o_PlayerTest.uPosition - GameCamera.view_x);
	dy = round(o_PlayerTest.vPosition - GameCamera.view_y);
	
	dx -= 4;
	dy -= 4;
		
	// Inventory bg
	draw_sprite(sui_inventory_box_0, 0, dx, dy);
		
	// Object sprite
	draw_sprite(object_get_sprite(m_held_inventory[0].object), 0, dx + 15, dy + 15);
		
	// Object count
	draw_set_color(c_white);
	draw_set_font(f_04b03);
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	draw_text(dx + 25, dy + 26, string(m_held_inventory[0].count));
}

gpu_set_blendmode(bm_normal);