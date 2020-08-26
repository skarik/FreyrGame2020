/// @description OnLeave

// Default trigger all the OnLeave triggers
for (var i = 0; i < array_length_1d(m_triggerOnLeave); ++i)
{
	with (m_triggerOnLeave[i])
	{
		event_user(kEvent_DefaultTrigger0);
	}
}