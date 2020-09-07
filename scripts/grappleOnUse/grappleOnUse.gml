function grappleOnUse(argument0) {
	var _itemType = argument0;

	// Reset all the timers
	dashTimer = 0.0; // We use the dash timer for all the behavior here.

	// We need to set the dash's other variables here as well
	moGrapple_isShooting = true;
	moGrapple_aimDirection = aimingDirection;
	moGrapple_hookX = x;
	moGrapple_hookY = y - 16;
	moGrapple_hookTargetX = x;
	moGrapple_hookTargetY = y - 16;
	moGrapple_startX = x;
	moGrapple_startY = y - 16;
	moGrapple_timerSpeed = 0.0;
	moGrapple_pauseTimer = 0.0; // Every grapple needs an impact timer in its life. Trust me. I know grapples.

	// Play audio
	var audio = sound_play_at(x, y, snd_GrappleFire);
		audio.pitch = 0.8;
		audio.gain = 0.6;

	// Set the new script
	moScriptOverride = _playerMotionGrapple;


}
