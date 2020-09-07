function _playerMoAttack2() {
	// Increment timer
	var l_meleeAtkTimerPrev = meleeAtkTimer;
	meleeAtkTimer += Time.deltaTime;
	// Get percent of time
	var l_meleePercent = clamp(meleeAtkTimer / meleeAtk2Time, 0.0, 1.0);

	// Do checks & motion
	_playerMoCommonAttackPreMove(power(1.0 - l_meleePercent, 0.5) * 0.25, true);

	// if before the hit time or after the early-key (hit->key) time, we can dash out of it
	var kMeleeAtkEarlyKey = lerp(meleeAtk0Hit, meleeAtk2Key, 0.5);
	if (meleeAtkTimer < meleeAtk2Hit || meleeAtkTimer > kMeleeAtkEarlyKey)
	{
		if (meleeDashQueued)
		{
			isAttacking = false;
			meleeDashQueued = false;
			meleeAtkQueued = false;
			_playerInteractDoDash();
		}
	}
	// do single signal damage
	if (l_meleeAtkTimerPrev < meleeAtk2Hit && meleeAtkTimer >= meleeAtk2Hit)
	{
		playerOnDealingDamage();
	
		// Sound for the attack
		var audio = sound_play_at(x, y, snd_npcWindstep);
		audio.pitch = random_range(0.8, 0.9);
		audio.gain = 0.7 / max(1.0, audio.pitch);
		audio.falloff_start = 20;
		audio.falloff_end = 500;
		audio.falloff_factor = 2;
	}
	// if passing the hit point, do the damage
	/*if ((l_meleeAtkTimerPrev < meleeAtk2Hit && meleeAtkTimer >= meleeAtk2Hit)
	 || (l_meleeAtkTimerPrev < (meleeAtk2Hit+meleeAtk2Key)/2 && meleeAtkTimer >= (meleeAtk2Hit+meleeAtk2Key)/2)
	 || (l_meleeAtkTimerPrev < meleeAtk2Key && meleeAtkTimer >= meleeAtk2Key))
	{
		// Damage!
		var hitboxCenterX = x + lengthdir_x(4, meleeAtkDirection);
		var hitboxCenterY = y + lengthdir_y(4, meleeAtkDirection);
		damageHitbox(id,
					 hitboxCenterX - 24, hitboxCenterY - 24,
					 hitboxCenterX + 24, hitboxCenterY + 24,
					 meleeAtk2Damage,
					 kDamageTypeUnarmed);
	}*/
	// if passing the hit point, do the damage
	if (l_meleeAtkTimerPrev < meleeAtk1Hit && meleeAtkTimer >= meleeAtk1Hit)
	{
		// Damage!
		var hitboxCenterX = x + lengthdir_x(4, meleeAtkDirection);
		var hitboxCenterY = y + lengthdir_y(4, meleeAtkDirection);
		damageHitbox(id,
					 hitboxCenterX - 12, hitboxCenterY - 12,
					 hitboxCenterX + 12, hitboxCenterY + 12,
					 meleeAtk2Damage,
					 kDamageTypeUnarmed);
	}
	// if past the key point, chain into next attack
	if (meleeAtkTimer > meleeAtk2Key)
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
	if (meleeAtkTimer > meleeAtk2Time)
	{
		meleeDashQueued = false;
		meleeAtkQueued = false;
		meleeAtkTimer = 0.0;
		isAttacking = false;
	}
	// if stunned, end early
	if (m_isStunned)
	{
		meleeDashQueued = false;
		meleeAtkQueued = false;
		meleeAtkTimer = 0.0;
		isAttacking = false;
	}

	// update animation
	sprite_index = kAnimAttack1;
	animationIndex = floor((image_number / 4.0 - 0.01) * saturate(meleeAtkTimer / meleeAtk2Time));


}
