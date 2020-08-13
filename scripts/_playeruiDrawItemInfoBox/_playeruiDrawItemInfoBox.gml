/// @function _playeruiDrawItemInfoBox(item_entry, x, y, vendor_info)
/// @param item_entry
/// @param x
/// @param y
/// @param vendor_info {Nullable}

var item = argument0;
var dix = argument1;
var diy = argument2;
var vendor_info = argument3;

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
	var title_width = draw_text_spaced(dix + 6, diy + 4, item.name, 2);
	
	// Draw item count after the name
	/*if (item.count != kCountPositiveInfinite)
	{
		draw_set_font(global.font_arvo7);
		draw_set_color(c_dkgray);
		draw_text_spaced(dix + 6 + title_width + 6, diy + 4 + 2, "x" + string(item.count), 2);
	}*/
	
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
			script_execute(item.onUi, // Following are arguments for onUi
						   item.object,
						   dix + 6, diy + 19,
						   base_alpha,
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
		else // Default case of unclassified item
		{
			draw_text_spaced(dix + 6, diy + 19, "Todo", 2);
		}
	}
	draw_set_valign(fa_top);
	
	//
	// draw trade info
	if (is_array(vendor_info))
	{
		var value = -1;
		var value_item = null;
		// find either the lowest or the least-fractional value
		for (var i = 0; i < array_length_1d(vendor_info); ++i)
		{
			var next_value = -1;
			var trade_type = vendor_info[i];
			
			if (trade_type == o_pickupRes_Bolt)
				next_value = temp_item.m_worthInGears * kResourceExchangeGearToBolts;
			else if (trade_type == o_pickupRes_Gear)
				next_value = temp_item.m_worthInGears;
			else if (trade_type == o_pickupRes_BoneShard)
				next_value = temp_item.m_worthInGears * kResourceExchangeGearToBoneShards;
			else if (trade_type == o_pickupRes_VoidShard)
				next_value = temp_item.m_worthInGears / kResourceExchangeVoidShardToGears;
				
			if (value == -1
				|| (next_value > 0.5 && abs(0.5 - frac(next_value)) > abs(0.5 - frac(value)))
				|| (next_value > 1.0 && next_value < value * 0.2)
				|| (value > 10 && next_value < value))
			{
				value = next_value;
				value_item = trade_type;
			}
		}
		
		if (value != -1 && value_item != null)
		{
			// Draw the value & the value measurement in the corner
			draw_set_font(c_uigold);
			draw_set_font(global.font_arvo7);
			draw_set_color(c_dkgray);
			var str_value = string_ltrim(string_format(value, 3, 1));
			var str_width = 0;
			if (string_char_at(str_value, string_length(str_value)) == "0")
			{
				str_value = string(round(value));
				str_width = string_width(str_value) * 2;
				draw_text_spaced(dix + dw * 2.0 - 4 - str_width, diy + 4, str_value, 2);
			}
			else
			{
				str_width = string_width(str_value) * 2;
				draw_text_spaced(dix + dw * 2.0 - 4 - str_width, diy + 4, str_value, 2);
			}
			draw_sprite(object_get_sprite(value_item), 0, dix + dw * 2.0 - 10 - str_width, diy + 10);
		}
	}
	// end draw trade info
	
	// Draw item info
	draw_set_font(global.font_arvo8);
	draw_set_color(merge_color(c_gold, c_white, 0.7));
	draw_text_spaced_wrap(dix + 6 + 1, diy + 12 + 19 + 1, temp_item.m_description, 2, dw * 2 - 11);
	draw_set_color(c_black);
	draw_text_spaced_wrap(dix + 6, diy + 12 + 19, temp_item.m_description, 2, dw * 2 - 11);
	
	// Remove temp item
	idelete(temp_item);
}