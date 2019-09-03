/// @function playerUiControlSelectFromArray(uv_info, current_selection, pos_array, scan_distance)
/// @param uv_info
/// @param current_selection
/// @param pos_array
/// @param scan_distance
/// @return new selection

var uv_info = argument0;
var prevAxis = uv_info[0];
var currAxis = uv_info[1];
var prevAxisMagnitude = uv_info[2];
var currAxisMagnitude = uv_info[3];
var prevAxisNormalized = uv_info[4];
var currAxisNormalized = uv_info[5];
var axisDirectionChange = uv_info[6];

var l_currentSelection = argument1;
var l_selectionArray = argument2;
var l_scanDistance = argument3;

var l_selectionArray_Length = array_length_1d(l_selectionArray);

if ((prevAxisMagnitude < kControlChoice_Margin && currAxisMagnitude >= kControlChoice_Margin)
	|| axisDirectionChange < 0.8)
{
	var l_currOptionPos = [0, 0];
	if (l_currentSelection != null)
		l_currOptionPos = l_selectionArray[l_currentSelection];
	var l_checkPos = [
		l_currOptionPos[0] + currAxisNormalized[0] * l_scanDistance,
		l_currOptionPos[1] + currAxisNormalized[1] * l_scanDistance
		];
	var l_closestChoice = null;
	var l_closestDistance = 1000;
				
	// Find the next closest option to the direction we're going:
	for (var i = 0; i < l_selectionArray_Length; ++i) 
	{
		if (i == l_currentSelection) continue;
					
		var l_checkOptionPos = l_selectionArray[i];
		var l_checkDelta = avec2_subtract(l_checkOptionPos, l_checkPos);
					
		// Make sure the option is in the cone of the direction
		var l_checkDeltaNormalized = avec2_normalized(l_checkDelta);
		if (avec2_dot(l_checkDeltaNormalized, currAxisNormalized) < 0.0)
			continue;
					
		// Make sure the option is the closest
		var l_checkDistance = avec2_length(l_checkDelta);
		if (l_checkDistance < l_closestDistance)
		{
			l_closestChoice = i;
			l_closestDistance = l_checkDistance;
		}
	}
				
	if (l_closestChoice != null)
	{
		l_currentSelection = l_closestChoice;
	}
}

return l_currentSelection;