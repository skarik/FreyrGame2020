/// @function _playeruiVendorStepItemBoxGlobal(box_state_array, box_draw_state_array, item_array_array, transfer_groups, button_state_array, button_draw_state_array)
/// @param inout box_state array
/// @param inout box_draw_state array
/// @param inout item_array array
/// @param in transfer_groups array
/// @param inout button_state array
/// @param inout button_draw_state array

var inout_box_state_array = argument0;
var inout_box_draw_state_array = argument1;

var inout_item_array_array = argument2;
var transfer_groups = argument3;

var inout_button_state_array = argument4;
var inout_button_draw_state_array = argument5;

if (array_length_1d(inout_box_state_array) != array_length_1d(inout_box_draw_state_array)
	&& array_length_1d(inout_box_state_array) != array_length_1d(inout_item_array_array))
{
	show_error("Bad args to _playeruiVendorStepItemBoxGlobal", false);
}

// Check if there is a selection:
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

// Cancel hover if not in the correct transfer group
if (box_state_selected != null)
{
	// Find the source item array
	var item_array_from = null;
	for (var i = 0; i < array_length_1d(inout_item_array_array); ++i)
	{
		if (box_state_selected == inout_box_state_array[i])
		{
			item_array_from = inout_item_array_array[i];
			break;
		}
	}
	// Find the proper transfer group
	var transfer_group = null;
	for (var i = 0; i < array_length_1d(transfer_groups); ++i)
	{
		if (array_contains(transfer_groups[i], item_array_from))
		{
			transfer_group = transfer_groups[i];
			break;
		}
	}
	// Check anything with hover, ensure they are in same transfer group
	for (var i = 0; i < array_length_1d(inout_box_state_array); ++i)
	{
		var box_state = inout_box_state_array[i];
		if (box_state != box_state_selected
			&& box_state[?"hover"] != null)
		{
			if (!array_contains(transfer_group, inout_item_array_array[i]))
			{
				box_state[?"hover"] = null;
			}
		}
	}
}

if (o_PlayerTest.selectButton.pressed)
{
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
		// Find the source item array
		var item_array_from = null;
		for (var i = 0; i < array_length_1d(inout_item_array_array); ++i)
		{
			if (box_state_selected == inout_box_state_array[i])
			{
				item_array_from = inout_item_array_array[i];
				break;
			}
		}
		// Swap with the first hover
		for (var i = 0; i < array_length_1d(inout_box_state_array); ++i)
		{
			var box_state = inout_box_state_array[i];
			if (box_state[?"hover"] != null)
			{
				var item_array_to = inout_item_array_array[i];
				itemEntrySwap(item_array_from[box_state_selected[?"selection"]], item_array_to[box_state[?"hover"]]);
				box_state_selected[?"selection"] = null;
				break;
			}
		}
	}
}

if(o_PlayerTest.cancelButton.pressed)
{
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