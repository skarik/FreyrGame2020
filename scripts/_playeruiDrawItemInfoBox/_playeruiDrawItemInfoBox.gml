/// @function _playeruiDrawItemInfoBox(item_entry, x, y)
/// @param item_entry
/// @param x
/// @param y

var item = argument0;
var dix = argument1;
var diy = argument2;

if (item != null)
{
	var base_alpha = draw_get_alpha();
	var dw = 76;
		
	draw_9slice_flex3(dix, diy, dw * 2.0, 80, sui_choiceBox3, 20, 20);
		
	// Draw item name
	draw_set_font(global.font_arvo8);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(merge_color(c_gold, c_white, 0.4));
	draw_set_alpha(base_alpha * 0.3);
	draw_text_spaced(dix + 6 + 0, diy + 4 + 1, item.name, 2);
	draw_text_spaced(dix + 6 + 1, diy + 4 + 0, item.name, 2);
	draw_set_alpha(base_alpha);
	draw_text_spaced(dix + 6 + 1, diy + 4 + 1, item.name, 2);
	draw_set_color(c_black);
	draw_text_spaced(dix + 6, diy + 4, item.name, 2);
				
	// Create temp item to get the additional information
	var temp_item = inew(item.object);
	temp_item.visible = false;
	//var temp_item = inew(_dummy);
	//with (temp_item) event_perform_object(item.object, ev_create, 0);
	
	// Draw item info
	draw_set_font(global.font_arvo7);
	draw_set_color(merge_color(c_gold, c_white, 0.4));
	draw_set_alpha(base_alpha * 0.3);
	draw_text_spaced_wrap(dix + 6 + 0, diy + 19 + 1, temp_item.m_description, 2, dw * 2 - 11 * 3);
	draw_text_spaced_wrap(dix + 6 + 1, diy + 19 + 0, temp_item.m_description, 2, dw * 2 - 11 * 3);
	draw_set_alpha(base_alpha);
	draw_text_spaced_wrap(dix + 6 + 1, diy + 19 + 1, temp_item.m_description, 2, dw * 2 - 11 * 3);
	draw_set_color(c_black);
	draw_text_spaced_wrap(dix + 6, diy + 19, temp_item.m_description, 2, dw * 2 - 11 * 3);
	
	// Remove temp item
	idelete(temp_item);
}