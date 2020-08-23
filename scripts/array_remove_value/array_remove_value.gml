///@function array_remove_value(array, value)
///@param array
///@param value

var array = argument0;
var value = argument1;

var new_array = [];
var new_array_index = 0;
for (var i = 0; i < array_length_1d(array); ++i)
{
	if (array[i] != value)
	{
		new_array[new_array_index] = array[i];
		new_array_index++;
	}
}

return new_array;