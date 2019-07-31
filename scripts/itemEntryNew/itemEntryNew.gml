var item = new(_dummy);
	item.persistent = true;
	item.object		= null;
	item.count		= 0;
	item.name		= "";
	item.checkUse	= nullScript;
	item.onUse		= nullScript;
	item.onDeplete	= nullScript;
	item.type		= kItemPickupNormal;

return item;