function _characterGobboHeavyMoMelee0() {
	var kMoveLength = 1.3;
	var kHitTime = 5/10 * kMoveLength;


	// Increment timer
	var prevMoveTimer = m_aiGobboHeavy_movetimer;
	m_aiGobboHeavy_movetimer += Time.deltaTime;
	var moveTimer = m_aiGobboHeavy_movetimer;

	// Set animation state
	isAttacking = true;

	// Get percent, used for animation
	var l_meleePercent = moveTimer / kMoveLength;

	// Set the direction
	if (prevMoveTimer <= 0.0)
	{
		meleeAtkDirection = facingDirection;
	}
	else
	{
		facingDirection = meleeAtkDirection;
	}

	// Do checks & motion
	_playerMoCommonAttackPreMove(power(1.0 - l_meleePercent, 2.0) * 0.5, true);

	// do the damage
	if (prevMoveTimer < kHitTime && moveTimer >= kHitTime)
	{
		// Damage!
		var hitboxCenterX = x + lengthdir_x(20, meleeAtkDirection);
		var hitboxCenterY = y + lengthdir_y(20, meleeAtkDirection);
		effectOnGroundHit(hitboxCenterX, hitboxCenterY);
		damageHitbox(id,
					 hitboxCenterX - 12, hitboxCenterY - 12,
					 hitboxCenterX + 12, hitboxCenterY + 12,
					 meleeAtk0Damage,
					 kDamageTypeBlunt);
	}

	// update animation
	sprite_index = kAnimAttack1;
	animationIndex =  floor((image_number / 4.0 - 0.01) * saturate(moveTimer / kMoveLength));

	// End case: dodge
	if (moveTimer < kHitTime)
	{
		if (meleeDashQueued)
		{
			moScriptOverride = _characterGobboHeavyMoJumpBack0;
			isAttacking = false;
			meleeDashQueued = false;
		
			m_aiGobboHeavy_movetimer = 0.0;
			exit;
		}
	}

	// End case
	if (prevMoveTimer < kMoveLength && moveTimer >= kMoveLength)
	{
		moScriptOverride = null;
		isAttacking = false;
		meleeDashQueued = false;
		exit;
	}


}
