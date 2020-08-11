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
		_playeruiDrawItemInfoBox(item, dix, diy);
	}
}