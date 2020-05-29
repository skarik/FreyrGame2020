/// @description Trigger check

var pl = getPlayer();
if (iexists(pl))
{
	var delta = [(pl.x - x) / image_xscale, (pl.y - y) / image_yscale];
	if (sqr(delta[0]) + sqr(delta[1]) < sqr(48))
	{
		with (m_target)
			event_user(0);
		
		if (m_triggerOnce)
			idelete(this);
	}
}