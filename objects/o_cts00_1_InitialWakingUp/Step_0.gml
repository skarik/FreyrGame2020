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
}

// Check for waits
if (!cutsceneUpdate())
{
}