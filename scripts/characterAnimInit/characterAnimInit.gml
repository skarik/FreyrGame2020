function characterAnimInit() {
	// Animation constants
	kAnimInvalid = sprite_index;
	kAnimStanding = sprite_index;
	kAnimWalking = sprite_index;
	kAnimRunning = kAnimWalking;
	kAnimRolling = sprite_index;
	kAnimAttack1 = sprite_index;
	kAnimStun = sprite_index;
	kAnimSinkFalling = sprite_index;
	kAnimAttack1 = sprite_index;
	kAnimDig1 = sprite_index;
	kAnimHarvest1 = sprite_index;
	kAnimKOed = sprite_index;

	// Top-down facing angle
	facingIndex = 0;
	facingDirection = 0;

	// Current animation state
	animationIndex = 0;
	animationSpeed = 0;

	moAnimationExternal = false; // Is animation current set externally?
	moAnimationPlayback = false; // Is animation in auto-playback mode?
	moAnimationPlaybackLooped = false;
	moAnimationPlaybackEndOnFinish = false;

	stepContinuousTimer = 0.0;

	// Draw offset
	moAnimationYOffset = 0.0;
	moAnimationYOffsetSpeed = 0.0;

	// Disable built-in animation
	image_speed = 0.0;


}
