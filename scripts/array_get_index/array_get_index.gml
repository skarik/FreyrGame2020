/// @function array_get_index(array, value)
/// @param array
/// @param value

var array = argument0;
var value = argument1;

var array_len = array_length_1d(array);
for (var i = 0; i < array_len; ++i)
{
	if (array[i] == value)
	{
		return i;
	}
}
return null;