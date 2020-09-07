/// @description itemEntryCopy(entry, source)
/// @param entry inits item to given params
/// @param source item!
function itemEntryCopy(argument0, argument1) {
	var source = argument1;
	var item = argument0;
		item.object		= source.object;
		item.count		= source.count;
		item.name		= source.name;
		item.checkUse	= source.checkUse;
		item.onUse		= source.onUse;
		item.onDeplete	= source.onDeplete;
		item.onUi		= source.onUi;
		item.type		= source.type;
		item.tradeItem	= source.tradeItem;
		item.userInfo	= source.userInfo;
		item.userInfoS	= source.userInfoS;


}
