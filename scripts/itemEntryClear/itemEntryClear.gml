/// @description itemEntryClear(entry)
/// @param entry inits item to empty slot
var item = argument0;
	item.object		= null;
	item.count		= 0;
	item.name		= "";
	item.checkUse	= nullScript;
	item.onUse		= nullScript;
	item.type		= kItemPickupNormal;