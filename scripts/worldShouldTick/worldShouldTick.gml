var pl = getPlayer();
if (iexists(pl))
{
	if (pl.m_isKOed)
	{
		return false;
	}
}

return true;