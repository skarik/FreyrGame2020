/// @description itemArrayAddItemProp(array, object, count, maxCount, name, checkUse, onUse, onDeplete, onUi, type, tradeItem, userInfo, userInfoString)
/// @param array
/// @param object
/// @param count
/// @param maxCount
/// @param name
/// @param checkUse
/// @param onUse
/// @param onDeplete
/// @param onUi
/// @param type
/// @param tradeItem
/// @param userInfo
/// @param userInfoString

var itemArray = argument0;
var itemArrayLength = array_length_1d(itemArray);

var new_object = argument1;
var new_count = argument2;
var max_count = argument3;
var new_name = argument4;
var new_checkUse = argument5;
var new_onUse = argument6;
var new_onDeplete = argument7;
var new_onUi = argument8;
var new_type = argument9;
var new_tradeItem = argument10;
var new_userInfo = argument11;
var new_userInfoS = argument12;

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
			itemArray[i].onUi = new_onUi;
			itemArray[i].type = new_type;
			itemArray[i].tradeItem = new_tradeItem;
			itemArray[i].userInfo = new_userInfo;
			itemArray[i].userInfoS = new_userInfoS;
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
		itemArray[i].onUi = new_onUi;
		itemArray[i].type = new_type;
		itemArray[i].tradeItem = new_tradeItem;
		itemArray[i].userInfo = new_userInfo;
		itemArray[i].userInfoS = new_userInfoS;
		return itemArray[i];
	}
}

return null;

