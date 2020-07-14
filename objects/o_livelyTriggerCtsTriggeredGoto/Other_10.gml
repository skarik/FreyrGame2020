/// @description Dispense Triggers Conditionally

var trigger = !m_flagComparisonEnabled;

if (m_flagComparisonEnabled)
{
	if (m_flagCompareIdToValue == kCompareOpLess)
	{
		trigger = (questGetValue(m_flagId) < m_flagValue);
	}
	else if (m_flagCompareIdToValue == kCompareOpGreater)
	{
		trigger = (questGetValue(m_flagId) > m_flagValue);
	}
	else if (m_flagCompareIdToValue == kCompareOpEqual)
	{
		trigger = (questGetValue(m_flagId) == m_flagValue);
	}
}

if (trigger)
{
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
}