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
	var dw = 86;
		
	draw_9slice_flex3(dix, diy, dw * 2.0, 92, sui_choiceBox3, 20, 20);
		
	// Draw item name
	draw_set_font(global.font_arvo9Bold);
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
	
	// In upper right, draw the rough trading value of it
	
	// Draw effects or trade params
	draw_set_font(global.font_arvo7);
	if (!vendorCanTradeItem(temp_item))
	{
		draw_set_color(c_gray);
		draw_text_spaced(dix + 6, diy + 19, "Not tradable", 2);
	}
	else
	{
		draw_set_color(c_gray);
		if (temp_item.m_flags & kItemFlagsConsumable)
		{
			/*
			var _itemType = argument0;
			var _itemDx = argument1;
			var _itemDy = argument2;
			var _itemDalpha = argument3;
			var _itemIsSelected = argument4;
			var _itemUiCategory = argument5;
			*/
			script_execute(item.onUi, // Following are arguments for onUi
						   item.object,
						   //dx + dspace * i + 15, dy + 15 + y_offset,
						   dix + 6, diy + 19,
						   //saturate( saturate(1.5 - abs(i - m_inventory_selector) * 2.0) + (is_hovered ? 1.0 : 0.0) ),
						   base_alpha,
						   //(i == inventory.belt_selection) || is_hovered, 
						   true,
						   kItemUiCategoryInspect);
		}
		else if (temp_item.m_flags & kItemFlagsYeetable)
		{
			draw_text_spaced(dix + 6, diy + 19, "Can Throw", 2);
		}
		else if (temp_item.m_type == kItemPickupResource)
		{
			draw_text_spaced(dix + 6, diy + 19, "Basic Resource", 2);
		}
		else if (temp_item.m_type == kItemPickupSeed)
		{
			draw_text_spaced(dix + 6, diy + 19, "Can Plant", 2);
		}
		else
		{
			draw_text_spaced(dix + 6, diy + 19, "Todo", 2);
		}
	}
	
	// Draw item info
	draw_set_font(global.font_arvo8);
	draw_set_color(merge_color(c_gold, c_white, 0.7));
	//draw_set_alpha(base_alpha * 0.3);
	//draw_text_spaced_wrap(dix + 6 + 0, diy + 19 + 1, temp_item.m_description, 2, dw * 2 - 11 * 3);
	//draw_text_spaced_wrap(dix + 6 + 1, diy + 19 + 0, temp_item.m_description, 2, dw * 2 - 11 * 3);
	//draw_set_alpha(base_alpha);
	draw_text_spaced_wrap(dix + 6 + 1, diy + 12 + 19 + 1, temp_item.m_description, 2, dw * 2 - 11);
	draw_set_color(c_black);
	draw_text_spaced_wrap(dix + 6, diy + 12 + 19, temp_item.m_description, 2, dw * 2 - 11);
	
	// Remove temp item
	idelete(temp_item);
}