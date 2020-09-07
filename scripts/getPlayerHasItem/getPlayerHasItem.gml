function getPlayerHasItem(argument0) {
	var item = argument0;

	if (item == kPitemLantern)
	{
		var pl = getPlayer();
		return pl.pstats.m_pitem[kPitemLantern];
	}


}
