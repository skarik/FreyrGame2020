function playerRemovePitem(argument0) {
	var pitem = argument0;
	var pl = getPlayer();
	var clearItem = null;

	pl.pstats.m_pitem[pitem] = 0;

	if (pitem == kPitemLantern)
	{
		clearItem = o_pickupTool_Lantern;
	}

	for (var i = 0; i < array_length_1d(pl.inventory.belt); ++i)
	{
		if (pl.inventory.belt[i].object == clearItem)
		{
			itemEntryClear(pl.inventory.belt[i]);
		}
	}
	for (var i = 0; i < array_length_1d(pl.inventory.bag); ++i)
	{
		if (pl.inventory.bag[i].object == clearItem)
		{
			itemEntryClear(pl.inventory.bag[i]);
		}
	}


}
