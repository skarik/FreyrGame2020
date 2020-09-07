function pstatsSave(argument0) {
	var buffer = argument0;
	var pl = getPlayer();

	savestateWriteBufferHeader(buffer, kSavestateHeader_PlayerStats, kSavestateVersion);

	with (pl.pstats)
	{
	
	}


}
