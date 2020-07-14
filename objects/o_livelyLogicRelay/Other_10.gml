/// @description Check trigger type

if (m_triggerMode == kTriggerReusable)
{
	event_inherited();
}
else if (m_triggerMode == kTriggerOncePerRoomload)
{
	event_inherited();
	idelete(this);
}
else if (m_triggerMode == kTriggerOncePerPlaythrough)
{
	if (iflagsGetValue(id) == 0)
	{
		iflagsSetValue(id, 1);
		event_inherited();
	}
	idelete(this);
}