var pl = getPlayer();
if (iexists(pl))
{
	if (pl.m_isDead)
	{
		return false;
	}
}

return true;