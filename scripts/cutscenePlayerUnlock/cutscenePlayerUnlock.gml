function cutscenePlayerUnlock() {
	var pl = getPlayer();

	// Unlock player
	pl.canMove = true;
	pl.moEnabled = true;
	pl.moAnimationPlayback = false;


}
