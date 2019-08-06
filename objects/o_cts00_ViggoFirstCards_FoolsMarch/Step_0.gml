/// @description ctsupdate

var pl = getPlayer();
var viggo = o_chViggo;

// Check for waits
if (!cutsceneUpdate())
{
	var cts_type = cutsceneGetCurrentType();
		
	// Make player fall
	if (cts_type == SEQTYPE_WAIT)
	{
		var wait_id = cutsceneGetWaitId();
		if (wait_id == "approach1")
		{
			// Consume all signals now
			cutsceneSignalConsume();
				
			// unlock player
			cutscenePlayerUnlock();
				
			// Check if player is outside
			if (point_distance(x, y, pl.x, pl.y) < 220
				|| point_distance(viggo.x, viggo.y, pl.x, pl.y) < 150)
			{
				cutscenePlayerLock();
					
				// Contine onward
				cutsceneWaitEnd();
			}
		}
		if (wait_id == "approach2")
		{
			// Consume all signals now
			cutsceneSignalConsume();
				
			// unlock player
			cutscenePlayerUnlock();
				
			// Check if player is outside
			if (point_distance(viggo.x, viggo.y, pl.x, pl.y) < 70)
			{
				cutscenePlayerLock();
					
				// Contine onward
				cutsceneWaitEnd();
			}
		}
	}
	// continue~
		
	if (cutsceneIsDone())
	{
		// unlock player
		cutscenePlayerUnlock();
		// mark dialogue as seen
		questSetValue(kQidViggoFirstCards, 1);
		// no longer need this
		delete(this);
	}
}