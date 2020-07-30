/// @description Run cutscene

if (!cutsceneUpdate())
{
	var cts_type = cutsceneGetCurrentType();
		
	if (cts_type == SEQTYPE_WAIT)
	{
		var wait_id = cutsceneGetWaitId();
		if (wait_id == "")
		{
			
		}
	}
}

if (cutsceneHasSignal())
{
	var signal_id = cutsceneGetSignal();
	
	if (signal_id == "")
	{
		cutsceneSignalConsume();
	}
}
