/// @description Check approach state

var pl = getPlayer();
var pl_dist_sqr = sqr(x - pl.x) + sqr(y - pl.y);
var glow_dist_sqr = sqr(80);

if (!m_statePlayerNearby)
{
	if (pl_dist_sqr < glow_dist_sqr)
	{
		m_statePlayerNearby = true;
	}
}
else
{
	if (pl_dist_sqr > glow_dist_sqr)
	{
		m_statePlayerNearby = false;
	}
}