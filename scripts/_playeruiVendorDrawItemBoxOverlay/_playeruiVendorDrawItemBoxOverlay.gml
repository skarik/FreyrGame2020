/// @function _playeruiVendorDrawItemBoxOverlay(xcenter, ytop, width, height, item_x, item_y, item_scale, itemArray, box_state, box_draw_state)
/// @param itemArray
/// @param inout box_state
/// @param inout box_draw_state

var item_array = argument0;

var inout_box_state = argument1;
var inout_box_draw_state = argument2;

var kBaseItemSpacing = 22;

// draw the item we're hovering over
if (!is_undefined(inout_box_state[?"hover"]) && inout_box_state[?"hover"] != null
	&& is_array(item_array))
{
	var item = item_array[inout_box_state[?"hover"]];
	if (item.object != null)
	{
		var offset = inout_box_draw_state[?inout_box_state[?"hover"]];
		var dix = offset[0] + (kBaseItemSpacing + 2) * inout_box_draw_state[?"scale"];
		var diy = offset[1] + 0;
		var dw = 76;
		
		draw_sprite_part(sui_choiceBox3, 0, 0,0,dw,20,			dix,		diy);
		draw_sprite_part(sui_choiceBox3, 0, 250-dw,0,dw,20,		dix + dw,	diy);
		draw_sprite_part(sui_choiceBox3, 1, 0,0,dw,20,			dix,		diy + 20);
		draw_sprite_part(sui_choiceBox3, 1, 250-dw,0,dw,20,		dix + dw,	diy + 20);
		draw_sprite_part(sui_choiceBox3, 1, 0,0,dw,20,			dix,		diy + 40);
		draw_sprite_part(sui_choiceBox3, 1, 250-dw,0,dw,20,		dix + dw,	diy + 40);
		draw_sprite_part(sui_choiceBox3, 2, 0,0,dw,20,			dix,		diy + 60);
		draw_sprite_part(sui_choiceBox3, 2, 250-dw,0,dw,20,		dix + dw,	diy + 60);
		
		// Draw item name & info as well
		draw_set_font(global.font_arvo8);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_color(c_gold);
		draw_text_spaced(dix + 6 + 1, diy + 4 + 1, item.name, 2);
		draw_set_color(c_black);
		draw_text_spaced(dix + 6, diy + 4, item.name, 2);
				
		// 
		var temp_item = inew(item.object);
		draw_set_font(global.font_arvo7);
		draw_set_color(c_gold);
		draw_text_spaced_wrap(dix + 6 + 1, diy + 19 + 1, temp_item.m_description, 2, dw * 2 - 11 * 3);
		draw_set_color(c_black);
		draw_text_spaced_wrap(dix + 6, diy + 19, temp_item.m_description, 2, dw * 2 - 11 * 3);
		idelete(temp_item);
	}
}