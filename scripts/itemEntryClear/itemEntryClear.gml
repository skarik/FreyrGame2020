/// @description itemEntryClear(entry)
/// @param entry inits item to empty slot
var item = argument0;
	item.object		= null;
	item.count		= 0;
	item.name		= "";
	item.checkUse	= itemNullScript;
	item.onUse		= itemNullScript;
	item.onDeplete	= itemNullScript;
	item.onUi		= itemNullUiScript;
	item.type		= kItemPickupNormal;
	item.tradeItem	= [null, 0];
	item.userInfo	= 0;
	item.userInfoS	= "";