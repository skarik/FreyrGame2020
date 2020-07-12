/// @description Dispense Triggers Conditionally

var trigger = false;

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

if (trigger)
{
	event_inherited();
}