///@function array_remove_index(array, index)
///@param array
///@param index

var array = argument0;
var index = argument1;

var new_array = [];
var new_array_index = 0;
for (var i = 0; i < array_length_1d(array); ++i)
{
	if (i != index)
	{
		new_array[new_array_index] = array[i];
		new_array_index++;
	}
}

return new_array;