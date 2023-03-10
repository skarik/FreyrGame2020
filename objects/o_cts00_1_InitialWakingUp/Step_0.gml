/// @description ctsupdate

var pl = getPlayer();

// Check signals
if (cutsceneHasSignal())
{
	var signal_id = cutsceneGetSignal();
	
	if (signal_id == "scene_setup")
	{
		pl.canMove = false; // Disable all motion input
		pl.onGround = false;
		pl.moEnabled = false;
		pl.zspeed = 0.0;
		pl.xspeed = 0.0;
		pl.yspeed = 0.0;
		
		// Set up the animation
		//pl.moAnimationPlayback = true;
		//pl.moAnimationPlaybackLooped = true;
		//pl.moAnimationPlaybackEndOnFinish = false;
		//pl.animationSpeed = 0.0;
		//pl.sprite_index = pl.kAnimStanding;
		
		with (pl.camera) camPlayerCenter(); // Center the camera.
		
		if (!iexists(o_chNathan))
		{
			var ch = inew(o_chNathan);
				ch.x = pl.x;
				ch.y = pl.y;
				//ch.facingDirection = 180;
		}
		
		// Consume!
		cutsceneSignalConsume();
	}
	if (signal_id == "ended")
	{
		// Unlock player
		pl.canMove = true;
		pl.moEnabled = true;
		pl.moAnimationPlayback = false;
		// Create music manager
		//inew(o_mus00_Oasis);
		// Set the final flag
		questSetValue(kQidIntroSequence, 20);
		// Consume!
		cutsceneSignalConsume();
	}
	
	
	if (signal_id == "nathan_cg_show")
	{
		inew_unique(o_cts00_10_CgNathan);
		with (o_cts00_10_CgNathan) { m_show = true; }
		cutsceneSignalConsume();
	}
	if (signal_id == "nathan_cg_hide")
	{
		with (o_cts00_10_CgNathan) { m_show = false; }
		cutsceneSignalConsume();
	}
}

// Check for waits
if (!cutsceneUpdate())
{
	var cts_type = cutsceneGetCurrentType();
	if (cts_type == SEQTYPE_WAIT)
	{
		/*var wait_id = cutsceneGetWaitId();
		if (wait_id == "nathan_cg")
		{
			if (!iexists(o_cts00_10_CgNathan))
			{
				cutsceneWaitEnd();
			}
		}*/
	}
}