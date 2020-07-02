/// @description Dispense Triggers Conditionally

var trigger = false;

if (m_flagCompareIdToValue == kCompareLess)
{
	trigger = (questGetValue(m_flagId) < m_flagValue);
}
else if (m_flagCompareIdToValue == kCompareGreater)
{
	trigger = (questGetValue(m_flagId) > m_flagValue);
}
else if (m_flagCompareIdToValue == kCompareEqual)
{
	trigger = (questGetValue(m_flagId) == m_flagValue);
}

if (trigger)
{
	event_inherited();
}