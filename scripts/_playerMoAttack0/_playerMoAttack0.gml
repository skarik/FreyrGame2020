// Increment timer
var l_meleeAtkTimerPrev = meleeAtkTimer;
meleeAtkTimer += Time.deltaTime;
// Get percent of time
var l_meleePercent = clamp(meleeAtkTimer / meleeAtk0Time, 0.0, 1.0);

// Modify move speed
_playerMoCommonAttackPreMove(power(1.0 - l_meleePercent, 2.0) * 0.5, true);

// if before the hit time or after the early-key (hit->key) time, we can dash out of it
var kMeleeAtkEarlyKey = lerp(meleeAtk0Hit, meleeAtk0Key, 0.5);
if (meleeAtkTimer < meleeAtk0Hit || meleeAtkTimer > kMeleeAtkEarlyKey)
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
if (l_meleeAtkTimerPrev < meleeAtk0Hit && meleeAtkTimer >= meleeAtk0Hit)
{
	// Damage!
	var hitboxCenterX = x + lengthdir_x(20, meleeAtkDirection);
	var hitboxCenterY = y + lengthdir_y(20, meleeAtkDirection);
	damageHitbox(id,
				 hitboxCenterX - 12, hitboxCenterY - 12,
				 hitboxCenterX + 12, hitboxCenterY + 12,
				 meleeAtk0Damage,
				 kDamageTypeUnarmed);
				 
	// Damage callback
	playerOnDealingDamage();
	
	// Sound for the hit
	var audio = sound_play_at(x, y, snd_npcWindstep);
	audio.pitch = random_range(0.8, 0.9);
	audio.gain = 0.7 / max(1.0, audio.pitch);
	audio.falloff_start = 20;
	audio.falloff_end = 500;
	audio.falloff_factor = 2;
}
// if past the key point, chain into next attack
if (meleeAtkTimer > meleeAtk0Key)
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
animationIndex = floor((image_number / 4.0 - 0.01) * saturate(meleeAtkTimer / meleeAtk0Time));