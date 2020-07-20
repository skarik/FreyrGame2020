/// @description Check collision

var run_trigger = false;
if ((m_triggerBy & kTriggerByPlayer))
{
	var pl = getPlayer();
	if (place_meeting(x, y, pl))
	{
		if (m_retriggerCountdown <= 0.0)
		{
			m_retriggerCountdown = m_retriggerDelay;
			event_user(0);
		}
	}
}

if (m_retriggerCountdown > 0.0)
{
	m_retriggerCountdown -= Time.deltaTime;
}