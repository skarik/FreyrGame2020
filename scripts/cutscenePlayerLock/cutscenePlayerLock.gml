function cutscenePlayerLock() {
	var pl = getPlayer();

	// Stop player then
	pl.canMove = false; // Disable all motion input
	pl.onGround = true;
	pl.moEnabled = false;
	pl.zspeed = 0.0;
			
	// Stop motion
	pl.xspeed = 0.0;
	pl.yspeed = 0.0;


}
