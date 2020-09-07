function itemEntrySwap(argument0, argument1) {
	var item0 = argument0;
	var item1 = argument1;

	var swap;

	// save 0				overwrite 0							move old 0 to 1
	swap = item0.object;	item0.object = item1.object;		item1.object = swap;
	swap = item0.count;		item0.count = item1.count;			item1.count = swap;
	swap = item0.name;		item0.name = item1.name;			item1.name = swap;
	swap = item0.checkUse;	item0.checkUse = item1.checkUse;	item1.checkUse = swap;
	swap = item0.onUse;		item0.onUse = item1.onUse;			item1.onUse = swap;
	swap = item0.onDeplete;	item0.onDeplete = item1.onDeplete;	item1.onDeplete = swap;
	swap = item0.onUi;		item0.onUi = item1.onUi;			item1.onUi = swap;
	swap = item0.type;		item0.type = item1.type;			item1.type = swap;
	swap = item0.tradeItem;	item0.tradeItem = item1.tradeItem;	item1.tradeItem = swap;
	swap = item0.userInfo;	item0.userInfo = item1.userInfo;	item1.userInfo = swap;
	swap = item0.userInfoS;	item0.userInfoS = item1.userInfoS;	item1.userInfoS = swap;


}
