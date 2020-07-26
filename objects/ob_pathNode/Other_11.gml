/// @description OnPass

debugOut("Dispensing trigger1 " + string(id) + " (" + object_get_name(object_index) + ")");

var t_count = array_length_1d(m_onPassTargets);
for (var i = 0; i < t_count; ++i)
{
	var t_event = m_onPassTargetEvents[i];
	with (m_onPassTargets[i])
	{
		event_user(t_event);
	}
}