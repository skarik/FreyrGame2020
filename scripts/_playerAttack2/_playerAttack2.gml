// Update checks
_playerMotionCommonChecks();

// Set up the move speed
var l_moveSpeed = kMoveSpeed;
if (inWater)
	l_moveSpeed *= kMoveSpeedWaterPercent;
if (isBlocking)
	l_moveSpeed *= kMoveSpeedBlockingPercent;
if (m_isHolding)
	l_moveSpeed *= kMoveSpeedCarryingPercent;

// Increment timer
var l_meleeAtkTimerPrev = meleeAtkTimer;
meleeAtkTimer += Time.deltaTime;

// Get percent of time
var l_meleePercent = clamp(meleeAtkTimer / meleeAtk2Time, 0.0, 1.0);

// Modify move speed
l_moveSpeed *= power(1.0 - l_meleePercent, 0.5) * 0.25;

// Move the player...
xspeed = lengthdir_x(l_moveSpeed, meleeAtkDirection);
yspeed = lengthdir_y(l_moveSpeed, meleeAtkDirection);

_playerMotionCommonCollision();

// Finally move
x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;

// if before the hit time or after the key time, we can dash out of it
if (meleeAtkTimer < meleeAtk2Hit || meleeAtkTimer > meleeAtk2Key)
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
}
// if passing the hit point, do the damage
if ((l_meleeAtkTimerPrev < meleeAtk2Hit && meleeAtkTimer >= meleeAtk2Hit)
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
				 kDamageTypeBlunt);
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