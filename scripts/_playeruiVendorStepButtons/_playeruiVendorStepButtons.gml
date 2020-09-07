/// @function _playeruiVendorStepButtons(button_state, button_draw_state)
/// @param inout button_state
/// @param inout button_draw_state
function _playeruiVendorStepButtons(argument0, argument1) {

	var inout_button_state = argument0;
	var inout_button_draw_state = argument1;

	var cursor_x = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
	var cursor_y = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));
	
	// reset if mouse move
	if (o_PlayerTest.uPosition != o_PlayerTest.uPositionPrevious
		|| o_PlayerTest.vPosition != o_PlayerTest.vPositionPrevious)
	{
		inout_button_state[?"hover"] = null;
	}

	var item_count = inout_button_draw_state[?"count"];
	if (is_undefined(item_count))
		item_count = 0;

	for (var i = 0; i < item_count; ++i)
	{
		var offset = inout_button_draw_state[?i];
		var box_x = offset[0];
		var box_y = offset[1];
		var box_w = offset[2];
		var box_h = offset[3];
		
		if (cursor_x >= box_x && cursor_x <= box_x + box_w
			&& cursor_y >= box_y && cursor_y <= box_y + box_h)
		{
			inout_button_state[?"hover"] = i;
			break;
		}
	}


}
