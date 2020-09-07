function _playerMotionGrapple() {
	var end_grapple_state = false;

	// Create grapple hook visual
	if (!iexists(o_fakeProjectileGrappleHook))
	{
		inew(o_fakeProjectileGrappleHook);
	}

	// If shooting grapple out, need to move grapple to the last set aiming direction
	if (moGrapple_isShooting)
	{
		// We move the grapple until either it's too far or it hits something
		var grappleMovement = 700.0 * Time.deltaTime;
		var grappleStep = 2.0;
		for (var i = 0; i < grappleMovement; i += grappleStep)
		{
			var step = min(grappleStep, grappleMovement - i);
		
			moGrapple_hookX += lengthdir_x(step, moGrapple_aimDirection);
			moGrapple_hookY += lengthdir_y(step, moGrapple_aimDirection);
		
			if (collision3_point_meeting(moGrapple_hookX, moGrapple_hookY, z, true))
			{
				moGrapple_isShooting = false;
				break;
			}
		}
	
		// Check if the hook is too far
		if (moGrapple_isShooting)
		{
			if (point_distance(x, y, moGrapple_hookX, moGrapple_hookY) > 256)
			{
				end_grapple_state = true;
			}
		}
		else
		{
			// Reset the start position
			moGrapple_startX = x;
			moGrapple_startY = y;
		
			// Set new end position
			moGrapple_hookTargetX = moGrapple_hookX - lengthdir_x(10, moGrapple_aimDirection);
			moGrapple_hookTargetY = moGrapple_hookY - lengthdir_y(10, moGrapple_aimDirection);
		
			// We hit something! We need to set grapple speed
			moGrapple_timerSpeed = 400.0 / point_distance(x, y, moGrapple_hookTargetX, moGrapple_hookTargetY);
		
			// Do the classic withstand sound effect
			var audio = sound_play_at(moGrapple_startX, moGrapple_startY, snd_GrappleImpact);
				audio.pitch = 1.05;
				audio.gain = 0.8;
		
			// Shake screen.
			effectScreenShake(2, 1 / 30.0, false);
		}
	
		// Todo: set shoot sprite
	}
	else if (moGrapple_pauseTimer < 1.0)
	{
		moGrapple_pauseTimer += Time.deltaTime / 0.1;
	}
	else
	{	
		// Move to the grapple position
		dashTimer += moGrapple_timerSpeed * Time.deltaTime;
	
		// Move the player
		x = lerp(moGrapple_startX, moGrapple_hookTargetX, saturate(dashTimer));
		y = lerp(moGrapple_startY, moGrapple_hookTargetY, saturate(dashTimer));

		// Todo: update Z

		// Todo: set fly sprite
	
		if (dashTimer >= 1.0)
		{
			end_grapple_state = true;
		}
	}

	// Fall to end grapple state
	if (end_grapple_state)
	{
		moScriptOverride = null;
		idelete(o_fakeProjectileGrappleHook);
	}


}
