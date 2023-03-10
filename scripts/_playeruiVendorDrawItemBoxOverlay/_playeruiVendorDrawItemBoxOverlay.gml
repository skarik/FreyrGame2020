/// @function _playeruiVendorDrawItemBoxOverlay(xcenter, ytop, width, height, item_x, item_y, item_scale, itemArray, box_state, box_draw_state)
/// @param itemArray
/// @param inout box_state
/// @param inout box_draw_state
function _playeruiVendorDrawItemBoxOverlay(argument0, argument1, argument2) {

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
			if (dix < GameCamera.width / 2.0)
				_playeruiDrawItemInfoBox(item, dix, diy, m_tradeBasis);
			else
				_playeruiDrawItemInfoBox(item, dix - 86 * 2 - 24, diy, m_tradeBasis);
		}
	}


}
