/// @description itemEntrySetProp(entry, object, count, name, checkUse, onUse, onDeplete, onUi, type, tradeItem, userInfo, userInfoString)
/// @param entry inits item to given params
/// @param object 
/// @param count
/// @param name 
/// @param checkUse 
/// @param onUse 
/// @param onDeplete
/// @param onUi
/// @param type 
/// @param tradeItem
/// @param userInfo
/// @param userInfoString
function itemEntrySetProp(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10, argument11) {
	var item = argument0;
		item.object		= argument1;
		item.count		= argument2;
		item.name		= argument3;
		item.checkUse	= argument4;
		item.onUse		= argument5;
		item.onDeplete	= argument6;
		item.onUi		= argument7;
		item.type		= argument8;
		item.tradeItem	= argument9;
		item.userInfo	= argument10;
		item.userInfoS	= argument11;


}
