/// @description itemEntryCopy(entry, source)
/// @param entry inits item to given params
/// @param source item!
var source = argument1;
var item = argument0;
	item.object		= source.object;
	item.count		= source.count;
	item.name		= source.name;
	item.checkUse	= source.checkUse;
	item.onUse		= source.onUse;
	item.onDeplete	= source.onDeplete;
	item.type		= source.type;
	item.tradeItem	= source.tradeItem;
	item.userInfo	= source.userInfo;
	item.userInfoS	= source.userInfoS;