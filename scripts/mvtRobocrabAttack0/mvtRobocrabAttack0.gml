if (live_call()) return live_result;

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
meleeAtkTimer += Time.deltaTime; // 1.5 seconds long.

// Get percent of time
//var l_meleePercent = clamp(meleeAtkTimer / meleeAtk0Time, 0.0, 1.0);

// Modify move speed
//l_moveSpeed *= power(1.0 - l_meleePercent, 2.0) * 0.5;

// Move the player...
//xspeed = lengthdir_x(l_moveSpeed, meleeAtkDirection);
//yspeed = lengthdir_y(l_moveSpeed, meleeAtkDirection);
xspeed = 0.0;
yspeed = 0.0;

_playerMotionCommonCollision();

// Finally move
x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;

// Time of 0.0 to 0.5 - Telegraph the attack.
var kTelegraphKey = meleeAtk0Key - 0.1;
if (l_meleeAtkTimerPrev < kTelegraphKey && meleeAtkTimer >= kTelegraphKey)
{
	var flasher = instance_create_depth(x, y - 5, depth - 10, o_ptcCircleHit);
		flasher.slowAccel = flasher.growSpeed * 3.0;
		flasher.fadePoint = 1000.0;
		flasher.fadeSpeed = 2;
}

// 0.5 to 1.5 - Three attacks
var kKey0 = meleeAtk0Key;
var kKey1 = (meleeAtk0Time - meleeAtk0Key) / 3.0 * 1.0 + meleeAtk0Key;
var kKey2 = (meleeAtk0Time - meleeAtk0Key) / 3.0 * 2.0 + meleeAtk0Key;
// rectangle_in_triangle

if (l_meleeAtkTimerPrev < kKey0 && meleeAtkTimer >= kKey0)
{
	// First zap effect
	var blast = instance_create_depth(x + lengthdir_x(8, aimingDirection),
									  y - 4 + lengthdir_y(8, aimingDirection),
									  depth - 10, o_ptcLineBlast);
		blast.image_angle = aimingDirection;
		blast.lx_pos_size = 4.0;
		blast.lx_pos_growSpeed = 400.0;
		blast.lx_pos_growSlow = 1600.0;
		blast.lx_neg_growSpeed = 30.0;
		blast.ly_pos_growSpeed = 90.0;
		blast.ly_neg_growSpeed = 90.0;
		blast.fadePoint = 0.0;
		blast.fadeSpeed = 4.0;
	
	var fxCx = x + lengthdir_x(lerp(beamAtkRanges[0], beamAtkRanges[1], 0.4), aimingDirection);
	var fxCy = y + lengthdir_y(lerp(beamAtkRanges[0], beamAtkRanges[1], 0.4), aimingDirection);
	
	var flasher = instance_create_depth(fxCx, fxCy, depth - 10, o_ptcCircleHit);
		flasher.slowAccel = flasher.growSpeed * 3.0;
		flasher.fadePoint = 1000.0;
		flasher.fadeSpeed = 2;
}
if (l_meleeAtkTimerPrev < kKey1 && meleeAtkTimer >= kKey1)
{
	var fxCx = x + lengthdir_x(lerp(beamAtkRanges[1], beamAtkRanges[2], 0.4), aimingDirection);
	var fxCy = y + lengthdir_y(lerp(beamAtkRanges[1], beamAtkRanges[2], 0.4), aimingDirection);
	
	var flasher = instance_create_depth(fxCx, fxCy, depth - 10, o_ptcCircleHit);
		flasher.slowAccel = flasher.growSpeed * 3.0;
		flasher.fadePoint = 1000.0;
		flasher.fadeSpeed = 2;
}
if (l_meleeAtkTimerPrev < kKey2 && meleeAtkTimer >= kKey2)
{
	var fxCx = x + lengthdir_x(lerp(beamAtkRanges[2], beamAtkRanges[3], 0.4), aimingDirection);
	var fxCy = y + lengthdir_y(lerp(beamAtkRanges[2], beamAtkRanges[3], 0.4), aimingDirection);
	
	var flasher = instance_create_depth(fxCx, fxCy, depth - 10, o_ptcCircleHit);
		flasher.slowAccel = flasher.growSpeed * 3.0;
		flasher.fadePoint = 1000.0;
		flasher.fadeSpeed = 2;
}

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
				 kDamageTypeBlunt);
}*/
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
}*/
// if past the length, end the attak
if (meleeAtkTimer > meleeAtk0Time)
{
	meleeDashQueued = false;
	meleeAtkQueued = false;
	meleeAtkTimer = 0.0;
	isAttacking = false;
	
	playerRevealHazard(kHazardRoboVoidShot);
}

// update animation
//sprite_index = kAnimAttack1;
//animationIndex = floor((image_number / 4.0 - 0.01) * saturate(meleeAtkTimer / meleeAtk0Time));