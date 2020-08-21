// Increment timer
var l_meleeAtkTimerPrev = meleeAtkTimer;
meleeAtkTimer += Time.deltaTime;

// Do checks & motion
_playerMoCommonAttackPreMove(0.0, false);

// if before the hit time or after the key time, we can dash out of it
/*if (meleeAtkTimer < meleeAtk0Hit || meleeAtkTimer > meleeAtk0Key)
{
	if (meleeDashQueued)
	{
		isAttacking = false;
		meleeDashQueued = false;
		meleeAtkQueued = false;
		_playerInteractDoDash();
	}
}*/
// If starting out, begin the particle system
if (l_meleeAtkTimerPrev <= 0.0 && meleeAtkTimer >= 0.0)
{
	magicMoveTarget = null;
}
// If passing the key point, do the heal effect
if (l_meleeAtkTimerPrev < magicMove0PreCast && meleeAtkTimer >= magicMove0PreCast)
{
	// Choose a thing to heal at this point
	magicMoveTarget = id;
}
// if passing the hit point, do the damage
if (l_meleeAtkTimerPrev < magicMove0Hit && meleeAtkTimer >= magicMove0Hit)
{
	// Heal!
	/*var hitboxCenterX = x + lengthdir_x(20, meleeAtkDirection);
	var hitboxCenterY = y + lengthdir_y(20, meleeAtkDirection);
	damageHitbox(id,
				 hitboxCenterX - 12, hitboxCenterY - 12,
				 hitboxCenterX + 12, hitboxCenterY + 12,
				 meleeAtk0Damage,
				 kDamageTypePiercing);*/
	// do heal at the hit point
	if (iexists(magicMoveTarget))
	{
		magicMoveTarget.stats.m_health += 16;
		magicMoveTarget.stats.m_stun += 2;
	}
}

// if past the length, end the attak
if (meleeAtkTimer > magicMove0Time)
{
	meleeDashQueued = false;
	meleeAtkQueued = false;
	meleeAtkTimer = 0.0;
	if (moScriptOverride == _characterGobboMageMoHeal0)
	{
		moScriptOverride = false;
	}
	else
	{
		isAttacking = false;
	}
}

// update animation
sprite_index = kAnimAttack1;
animationIndex = floor((image_number / 4.0 - 0.01) * saturate(meleeAtkTimer / magicMove0Time));