/// @function itemArrayCreate(length)
/// @param length

var itemArrayLength = argument0;

var array = array_create(itemArrayLength);
for (var i = 0; i < itemArrayLength; ++i)
{
	array[i] = itemEntryNew();
}

return array;