var item = new(_dummy);
	item.persistent = true;
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

return item;