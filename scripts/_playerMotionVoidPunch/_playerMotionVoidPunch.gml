function _playerMotionVoidPunch() {
	// Update checks
	_playerMotionCommonChecks();

	// Increment timer
	var l_meleeAtkTimerPrev = dashTimer;
	dashTimer += Time.deltaTime * 1.6;

	// Get percent of time
	//var l_meleePercent = clamp(dashTimer / meleeAtk0Time, 0.0, 1.0);

	// Modify move speed
	//l_moveSpeed *= power(1.0 - l_meleePercent, 2.0) * 0.5;

	// Move the player...
	xspeed = 0.0;//lengthdir_x(l_moveSpeed, meleeAtkDirection);
	yspeed = 0.0;//lengthdir_y(l_moveSpeed, meleeAtkDirection);

	_playerMotionCommonCollision();

	var voidPunchKey = 0.5 / 7;
	var voidPunchHit =  2.5 / 7;

	// Finally move
	x += xspeed * Time.deltaTime;
	y += yspeed * Time.deltaTime;

	// if before the hit time or after the key time, we can dash out of it
	if (dashTimer < voidPunchHit || dashTimer > voidPunchKey)
	{
		if (meleeDashQueued)
		{
			isAttacking = false;
			meleeDashQueued = false;
			meleeAtkQueued = false;
			_playerInteractDoDash();
		}
	}
	// if passing the hit point, do the damage
	if (l_meleeAtkTimerPrev < voidPunchHit && dashTimer >= voidPunchHit)
	{
		// Damage!
		/*var hitboxCenterX = x + lengthdir_x(20, meleeAtkDirection);
		var hitboxCenterY = y + lengthdir_y(20, meleeAtkDirection);
		damageHitbox(id,
					 hitboxCenterX - 12, hitboxCenterY - 12,
					 hitboxCenterX + 12, hitboxCenterY + 12,
					 meleeAtk0Damage,
					 kDamageTypeBlunt);*/
	
		// Create the floating power source
		var voidPower = instance_create_depth(x, y, depth - 10, o_livelyFloatingVoidPower);
			voidPower.m_strength = min(m_voidPunch_fill, m_voidPunch_charged);
	
		// Sap the needed energy
		m_voidPunch_fill = saturate(m_voidPunch_fill - m_voidPunch_charged);
		m_voidPunch_charged = 0.0;
				 
		// do the effect now
		effectOnGroundHit(x, y);
	}
	// if past the key point, chain into next attack
	/*if (meleeAtkTimer > meleeAtk0Key)
	{
		if (meleeAtkQueued)
		{
			meleeAtkQueued = true;
			meleeAtkTimer = 0.0;
			meleeDashQueued = false;
			meleeAtkQueued = false;
			meleeAtkDirection = aimingDirection;
			meleeAtkCurrent += 1;
		}
	}
	// if past the length, end the attak
	if (meleeAtkTimer > meleeAtk0Time)
	{
		meleeDashQueued = false;
		meleeAtkQueued = false;
		meleeAtkTimer = 0.0;
		isAttacking = false;
	}*/

	// update animation
	moAnimationExternal = true;
	sprite_index = kAnimDig1;
	animationIndex = floor((image_number / 4.0 - 0.01) * saturate(dashTimer));

	// end punch
	if (dashTimer >= 1.0)
	{
		moAnimationExternal = false;
		moScriptOverride = null;
	}


}
