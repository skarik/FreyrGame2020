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
		debugOut("Starting cutscene " + string(id) + " of file " + m_cutsceneFile);

		// Create the temporary cutscene object
		var callee = id;
		var cts = inew(ob_ctsAutomated);
		with (cts)
		{
			cutsceneLoad(callee.m_cutsceneFile);
		} // It should run on its own.
	}
	
	if (t_deleteAfter)
	{
		idelete(this);
	}
}