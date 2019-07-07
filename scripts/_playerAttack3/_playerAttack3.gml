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
var l_meleePercent = clamp(meleeAtkTimer / meleeAtk3Time, 0.0, 1.0);

// Modify move speed
l_moveSpeed *= power(1.0 - l_meleePercent, 2.0);

// Move the player...
xspeed = lengthdir_x(l_moveSpeed, meleeAtkDirection);
yspeed = lengthdir_y(l_moveSpeed, meleeAtkDirection);

_playerMotionCommonCollision();

// Finally move
x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;

// if before the hit time or after the key time, we can dash out of it
if (meleeAtkTimer < meleeAtk3Hit || meleeAtkTimer > meleeAtk3Key)
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
if (l_meleeAtkTimerPrev < meleeAtk3Hit && meleeAtkTimer >= meleeAtk3Hit)
{
	// Damage!
	var hitboxCenterX = x + lengthdir_x(22, meleeAtkDirection);
	var hitboxCenterY = y + lengthdir_y(22, meleeAtkDirection);
	damageHitbox(id,
				 hitboxCenterX - 16, hitboxCenterY - 16,
				 hitboxCenterX + 16, hitboxCenterY + 16,
				 meleeAtk3Damage,
				 kDamageTypeBlunt);
}
// if past the key point, chain into next attack
if (meleeAtkTimer > meleeAtk3Key)
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
if (meleeAtkTimer > meleeAtk3Time)
{
	meleeDashQueued = false;
	meleeAtkQueued = false;
	meleeAtkTimer = 0.0;
	isAttacking = false;
}

// update animation
sprite_index = kAnimAttack1;
animationIndex = floor((image_number / 4.0 - 0.01) * saturate(meleeAtkTimer / meleeAtk3Time));