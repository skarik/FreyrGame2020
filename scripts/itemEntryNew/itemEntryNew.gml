var item = new(_dummy);
	item.persistent = true;
	item.object		= null;
	item.count		= 0;
	item.name		= "";
	item.checkUse	= nullScript;
	item.onUse		= nullScript;
	item.onDeplete	= nullScript;
	item.type		= kItemPickupNormal;
	item.tradeItem	= [null, 0];
	item.userInfo	= 0;
	item.userInfoS	= "";

return item;