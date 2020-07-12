/// @description Dispense Triggers

debugOut("Dispensing trigger " + string(id) + " (" + object_get_name(object_index) + ")");

var t_count = array_length_1d(m_targets);
for (var i = 0; i < t_count; ++i)
{
	var t_event = m_targetEvents[i];
	with (m_targets[i])
	{
		event_user(t_event);
	}
}