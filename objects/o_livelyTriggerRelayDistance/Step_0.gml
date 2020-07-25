/// @description Trigger check

var run_trigger = false;
if ((m_triggerBy & kTriggerByPlayer))
{
	var pl = getPlayer();
	if (iexists(pl))
	{
		var delta = [(pl.x - x) / image_xscale, (pl.y - y) / image_yscale];
		if (sqr(delta[0]) + sqr(delta[1]) < sqr(48))
		{
			run_trigger = true;
		}
	}
}

if (run_trigger)
{
	if (m_retriggerCountdown <= 0.0)
	{
		m_retriggerCountdown = m_retriggerDelay;
		event_user(0);
	}
}

if (m_retriggerCountdown > 0.0)
{
	m_retriggerCountdown -= Time.deltaTime;
}