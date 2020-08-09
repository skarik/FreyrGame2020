/// @function _playeruiVendorDrawItemBox(xcenter, ytop, width, height, item_x, item_y, item_scale, itemArray, box_state, box_draw_state)
/// @param xcenter
/// @param ytop
/// @param width
/// @param height
/// @param item_x
/// @param item_y
/// @param item_scale
/// @param itemArray
/// @param inout box_state
/// @param inout box_draw_state

var dxcenter = argument0;
var dytop = argument1;
var dhalfwidth = argument2 / 2.0;
var dheight = argument3;
var item_count_x = argument4;
var item_count_y = argument5; // Ignored, mostly.
var item_scale = argument6;
var item_array = argument7;

var inout_box_state = argument8;
var inout_box_draw_state = argument9;

var kBaseItemSpacing = 22;

// Draw background
draw_set_color(c_white);
draw_rectangle(dxcenter - dhalfwidth, dytop, dxcenter + dhalfwidth, dytop + dheight, false);

// Generate Y-layout based on number of rows
var l_itemTotalCount = (item_array != null) ? array_length_1d(item_array) : 1;
var l_itemRowCount = max(item_count_y, ceil(l_itemTotalCount / item_count_x));

var l_itemSpacingY = ceil(max(kBaseItemSpacing * item_scale, dheight / l_itemRowCount));

var l_upscaling = item_scale > 1.0;

inout_box_draw_state[?"count"] = l_itemTotalCount;
inout_box_draw_state[?"scale"] = item_scale;

// Draw all the items row-by-row
for (var i_itemRow = 0; i_itemRow < l_itemRowCount; ++i_itemRow)
{
	// Generate the spacing for this row based on how many items will be in it
	var l_itemEntryNumber = min(max(0.0, l_itemTotalCount - i_itemRow * item_count_x), item_count_x);
	var l_itemSpacingX = ceil(max(l_itemSpacingY * 0.5, dhalfwidth * 2.0 / l_itemEntryNumber));
	
	var l_itemOffsetX = (l_itemEntryNumber * l_itemSpacingX - (dhalfwidth * 2.0) - (l_itemSpacingX - kBaseItemSpacing * item_scale)) * -0.5;
	
	// loop thru the current row and draw
	for (var i_itemEntry = 0; i_itemEntry < l_itemEntryNumber; ++i_itemEntry)
	{
		var i_itemIndex = i_itemRow * item_count_x + i_itemEntry;
		
		var ditemx = dxcenter - dhalfwidth + l_itemSpacingX * i_itemEntry + 1 + l_itemOffsetX;
		var ditemy = dytop + l_itemSpacingY * i_itemRow + 2;
	
		// store draw position in caller
		inout_box_draw_state[?i_itemIndex] = [ditemx, ditemy];
	
		// draw box
		draw_sprite_ext(sui_bagBox, 0, ditemx - 4 * item_scale, ditemy - 4 * item_scale, item_scale, item_scale, 0.0, c_white, 1.0);
		
		if (item_array != null && i_itemIndex < l_itemTotalCount)
		{
			var item = item_array[i_itemIndex];
			
			// Draw the item!
			if (item.object != null)
			{
				draw_sprite_ext(object_get_sprite(item.object), 0, ditemx + 11 * item_scale, ditemy + 11 * item_scale, item_scale, item_scale, 0.0, c_white, 1.0);
			}
		}
		
		// draw the hover selection
		if (inout_box_state[?"hover"] == i_itemIndex)
		{
			gpu_set_blendmode(bm_add);
			draw_set_color(merge_color(c_dkgray, c_gold, sin(current_time * 0.01) * 0.5 + 0.5));
			draw_rectangle(
				ditemx + 11 - 11, ditemy + 11 - 11,
				ditemx + 11 + 9,  ditemy + 11 + 9,
				true);
			draw_set_color(c_white);
			gpu_set_blendmode(bm_normal);
		}
		// draw the REAAAAL selection
		if (inout_box_state[?"selection"] == i_itemIndex)
		{
			gpu_set_blendmode(bm_add);
			draw_set_color(c_gold);
			draw_rectangle(
				ditemx + 11 - 10, ditemy + 11 - 10,
				ditemx + 11 + 8,  ditemy + 11 + 8,
				true);
			draw_set_color(c_white);
			gpu_set_blendmode(bm_normal);
		}
	}
}
