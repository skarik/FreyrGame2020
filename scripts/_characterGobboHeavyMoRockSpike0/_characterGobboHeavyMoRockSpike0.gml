///@function _characterGobboHeavyMoRockSpike0()
var kMoveLength = 1.3;
var kHitTime = 5/10 * kMoveLength;
var kCastTime1 = 6.0/10 * kMoveLength;
var kCastTime2 = 7.0/10 * kMoveLength;
var kCastTime3 = 8.0/10 * kMoveLength;

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

// do the cast effect
if (prevMoveTimer < kCastTime1 && moveTimer >= kCastTime1)
{
	// spawn the attack bit in a line, of them
	var hitboxCenterX = x + lengthdir_x(40, meleeAtkDirection);
	var hitboxCenterY = y + lengthdir_y(40, meleeAtkDirection);
	
	instance_create_depth(hitboxCenterX, hitboxCenterY, 0, o_fxStoneSpike);
	effectOnGroundHit(hitboxCenterX, hitboxCenterY);
	damageHitbox(id,
				 hitboxCenterX - 22, hitboxCenterY - 22,
				 hitboxCenterX + 22, hitboxCenterY + 22,
				 meleeAtk0Damage,
				 kDamageTypeBlunt);
}
if (prevMoveTimer < kCastTime2 && moveTimer >= kCastTime2)
{
	// spawn the attack bit in a line, of them
	var hitboxCenterX = x + lengthdir_x(70, meleeAtkDirection);
	var hitboxCenterY = y + lengthdir_y(70, meleeAtkDirection);
	
	instance_create_depth(hitboxCenterX, hitboxCenterY, 0, o_fxStoneSpike);
	effectOnGroundHit(hitboxCenterX, hitboxCenterY);
	damageHitbox(id,
				 hitboxCenterX - 22, hitboxCenterY - 22,
				 hitboxCenterX + 22, hitboxCenterY + 22,
				 meleeAtk0Damage,
				 kDamageTypeBlunt);
}
if (prevMoveTimer < kCastTime2 && moveTimer >= kCastTime2)
{
	// spawn the attack bit in a line, of them
	var hitboxCenterX = x + lengthdir_x(100, meleeAtkDirection);
	var hitboxCenterY = y + lengthdir_y(100, meleeAtkDirection);
	
	instance_create_depth(hitboxCenterX, hitboxCenterY, 0, o_fxStoneSpike);
	effectOnGroundHit(hitboxCenterX, hitboxCenterY);
	damageHitbox(id,
				 hitboxCenterX - 22, hitboxCenterY - 22,
				 hitboxCenterX + 22, hitboxCenterY + 22,
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