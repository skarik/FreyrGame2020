/// @description itemArrayAddItemProp(array, object, count, maxCount, name, checkUse, onUse, type)
/// @param array
/// @param object
/// @param count
/// @param maxCount
/// @param name
/// @param checkUse
/// @param onUse
/// @param type

var itemArray = argument0;
var itemArrayLength = array_length_1d(itemArray);

var new_object = argument1;
var new_count = argument2;
var max_count = argument3;
var new_name = argument4;
var new_checkUse = argument5;
var new_onUse = argument6;
var new_onDeplete = argument7;
var new_type = argument8;

// Loop through the inventory, if find a matching item
for (var i = 0; i < itemArrayLength; ++i)
{
	if (itemArray[i].object == new_object)
	{
		if (itemArray[i].count < max_count)
		{
			itemArray[i].count += new_count; // TODO properly support stacks
			itemArray[i].name = new_name;
			itemArray[i].checkUse = new_checkUse;
			itemArray[i].onUse = new_onUse;
			itemArray[i].onDeplete = new_onDeplete;
			itemArray[i].type = new_type;
			return itemArray[i];
		}
	}
}

// Otherwise, look for an empty spot
for (var i = 0; i < itemArrayLength; ++i)
{
	if (itemArray[i].object == null)
	{
		itemArray[i].object = new_object;
		itemArray[i].count = new_count;
		itemArray[i].name = new_name;
		itemArray[i].checkUse = new_checkUse;
		itemArray[i].onUse = new_onUse;
		itemArray[i].onDeplete = new_onDeplete;
		itemArray[i].type = new_type;
		return itemArray[i];
	}
}

return null;

