var buffer = argument0;
var pl = getPlayer();

if (!savestateCheckBufferHeader(buffer, kSavestateHeader_PlayerStats))
{
	return;
}

with (pl.pstats)
{
	
}