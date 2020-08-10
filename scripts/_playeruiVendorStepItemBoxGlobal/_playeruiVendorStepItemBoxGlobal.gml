/// @function _playeruiVendorStepItemBoxGlobal(box_state_array, box_draw_state_array)
/// @param inout box_state_array
/// @param inout box_draw_state_array

var inout_box_state_array = argument0;
var inout_box_draw_state_array = argument1;

if (o_PlayerTest.selectButton.pressed)
{
	var box_state_selected = null;
	for (var i = 0; i < array_length_1d(inout_box_state_array); ++i)
	{
		var box_state = inout_box_state_array[i];
		if (box_state[?"selection"] != null)
		{
			box_state_selected = box_state;
			break;
		}
	}
	
	// No selection?
	if (box_state_selected == null)
	{
		// Clear out all selection
		for (var i = 0; i < array_length_1d(inout_box_state_array); ++i)
		{
			var box_state = inout_box_state_array[i];
			box_state[?"selection"] = null;
		}
		// Select the first hover
		for (var i = 0; i < array_length_1d(inout_box_state_array); ++i)
		{
			var box_state = inout_box_state_array[i];
			if (box_state[?"hover"] != null)
			{
				box_state[?"selection"] = box_state[?"hover"];
				break;
			}
		}
	}
	// Have selection?
	else
	{
		// TODO: Swap with given selection
	}
}

if(o_PlayerTest.cancelButton.pressed)
{
	var box_state_selected = null;
	for (var i = 0; i < array_length_1d(inout_box_state_array); ++i)
	{
		var box_state = inout_box_state_array[i];
		if (box_state[?"selection"] != null)
		{
			box_state_selected = box_state;
			break;
		}
	}
	
	// Selection?
	if (box_state_selected != null)
	{
		box_state_selected[?"selection"] = null;
		// Clear out all selection for sanity purposes
		for (var i = 0; i < array_length_1d(inout_box_state_array); ++i)
		{
			var box_state = inout_box_state_array[i];
			box_state[?"selection"] = null;
		}
	}
}