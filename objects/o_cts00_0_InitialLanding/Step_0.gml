/// @description ctsupdate

var pl = getPlayer();

// Check signals
if (cutsceneHasSignal())
{
	var signal_id = cutsceneGetSignal();
	
	if (signal_id == "player_fall_setup")
	{
		pl.canMove = false; // Disable all motion input
		pl.x = pl.xstart;
		pl.y = pl.ystart;
		pl.z_height = kFallHeight;
		pl.onGround = false;
		pl.moEnabled = false;
		pl.zspeed = 0.0;
		
		// Set up the animation
		pl.moAnimationPlayback = true;
		pl.moAnimationPlaybackLooped = true;
		pl.animationSpeed = 10.0;
		pl.sprite_index = pl.kAnimSinkFalling;
		
		with (pl.camera) camPlayerCenter(); // Center the camera.
		
		if (!exists(o_chNathan))
		{
			var ch = new(o_chNathan);
				ch.x = pl.x - 55;
				ch.y = pl.y - 4;
				ch.facingDirection = 180;
		}
		
		// Do not consume
	}
	else if (signal_id == "player_fall")
	{
		cutsceneSignalConsume();
		pl.z_height = kFallHeight;
		pl.moEnabled = false;
		
		// Play the fall audio
		sound_play_at(pl.x, pl.y, snd_Cts00Falling);
	}
	else if (signal_id == "nathan_jump")
	{
		cutsceneSignalConsume();
		
		// And nathan should jump:
		o_chNathan.zspeed = 64;
		o_chNathan.z_height = 2;
		o_chNathan.onGround = false;
	}
	else if (signal_id == "round_positions")
	{
		cutsceneSignalConsume();
		o_chNathan.x = round(o_chNathan.x);
		pl.x = round(pl.x);
	}
	else if (signal_id == "nathan_drag")
	{
		o_chNathan.x -= 6.0 * Time.deltaTime;
		pl.x -= 6.0 * Time.deltaTime;
		
		o_chNathan.onGround = true;
		o_chNathan.moEnabled = true;
		o_chNathan.zspeed = 0;
		o_chNathan.z_height = 0;
	}
	else if (signal_id == "ended")
	{
		pl.z_height = 0;
		pl.inWater = false;
		
		questSetValue(kQidIntroSequence, 10);
		transition_to(rm_oasis_town);
	}
}

// Check for waits
if (!cutsceneUpdate())
{
	var cts_type = cutsceneGetCurrentType();
	
	// Make player fall
	if (cts_type == SEQTYPE_WAIT)
	{
		var wait_id = cutsceneGetWaitId();
		if (wait_id == "player_fall")
		{
			pl.zspeed -= 128.0 * Time.deltaTime;
			pl.z_height += pl.zspeed * Time.deltaTime;
			
			with (pl)
			{
				camPlayerCenter(); // Center the camera.
				camPlayerUpdate(round(x), round(y - z_height), 0, 0);
				camPlayerCenter(); // Center the camera.
				camPlayerUpdate(round(x), round(y - z_height), 0, 0);
			}
			
			// Wait for player to fall to the ground
			if (pl.z_height <= 0.0)
			{
				pl.z_height = 0.0;
				pl.zspeed = 0.0;
				pl.sprite_index = s_charHeroDeadFloat;
				
				// Make a splash
				with (pl)
				{
					for (var i = 0; i < 8; ++i)
					{
						var fader = instance_create_depth(x, y, depth, o_shoreCircleBallFader);
							fader.x += random_range(-8, +8);
							fader.y += random_range(-4, +4);
							fader.image_xscale = random_range(1.0, 4.0) / 64.0;
							fader.image_yscale = fader.image_xscale * 0.75;
					}
				}
				
				sound_play_at(pl.x, pl.y, snd_Cts00Splash);
				
				// End the wait
				cutsceneWaitEnd();
			}
		}
		else if (wait_id == "nathan_turn")
		{
			// Turn Nathan around
			o_chNathan.facingDirection -= 370.0 * Time.deltaTime;
			if (o_chNathan.facingDirection <= 0.0)
			{
				o_chNathan.facingDirection = 0.0;
				
				// End the wait
				cutsceneWaitEnd();
			}
		}
	}
}