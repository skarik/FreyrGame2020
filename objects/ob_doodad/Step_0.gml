depthUpdate();

//event_user(0);

if (m_alarmCulling-- <= 0)
{
	event_user(0);
	m_alarmCulling = max(4, choose(ceil(300 / fps), 4, 8, 16));
}