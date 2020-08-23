depthUpdate();

//event_user(0);

if (m_alarmCulling-- <= 0)
{
	event_user(0);
	m_alarmCulling = min(60, max(4, choose(ceil(300 / max(1, fps)), 4, 8, 16)));
}