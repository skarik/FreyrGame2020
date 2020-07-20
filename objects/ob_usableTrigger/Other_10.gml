/// @description On use - Dispense Triggers

// TODO: let all characters use
if (m_usable && iexists(m_user) && m_user.id == o_PlayerTest.id) 
{
	var t_runTrigger = false;
	var t_deleteAfter = false;
	
	if (m_triggerMode == kTriggerReusable)
	{
		t_runTrigger = true;
	}
	else if (m_triggerMode == kTriggerOncePerRoomload)
	{
		t_runTrigger = true;
		t_deleteAfter = true;
	}
	else if (m_triggerMode == kTriggerOncePerPlaythrough)
	{
		if (iflagsGetValue(id) == 0)
		{
			iflagsSetValue(id, 1);
			t_runTrigger = true;
		}
		t_deleteAfter = true;
	}
	
	if (t_runTrigger)
	{
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
	}
	
	if (t_deleteAfter)
	{
		idelete(this);
	}
}