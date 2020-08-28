///@function _characterGobboHeavyMoRockScatter0()
var kMoveLength = 1.4;
var kHitTime = 5/12 * kMoveLength;
var kCastTime = 6/12 * kMoveLength;
var kWhackTime = 9/12 * kMoveLength;


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
if (prevMoveTimer < kCastTime && moveTimer >= kCastTime)
{
	// spawn the attack bit in a line, of them
	var hitboxCenterX = x + lengthdir_x(28, meleeAtkDirection);
	var hitboxCenterY = y + lengthdir_y(28, meleeAtkDirection);
	
	instance_create_depth(hitboxCenterX, hitboxCenterY, 0, o_fxStoneSpike);
	effectOnGroundHit(hitboxCenterX, hitboxCenterY);
}

// whack the hovering stone
if (prevMoveTimer < kWhackTime && moveTimer >= kWhackTime)
{
	// spawn the attack bit in a line, of them
	var hitboxCenterX = x + lengthdir_x(23, meleeAtkDirection);
	var hitboxCenterY = y + lengthdir_y(23, meleeAtkDirection);
	
	/*instance_create_depth(hitboxCenterX, hitboxCenterY, 0, o_fxStoneSpike);
	effectOnGroundHit(hitboxCenterX, hitboxCenterY);*/
	
	// Create three projectiles going forward
	for (var i = 0; i < 3; ++i)
	{
		var angleOffset = (i - 1) * 30;
		
		var projectile = instance_create_depth(hitboxCenterX, hitboxCenterY, depth, o_projectileRockScatter);
			projectile.m_owner = id;
			projectile.m_team = m_team;
			projectile.xspeed = lengthdir_x(300, meleeAtkDirection + angleOffset);
			projectile.yspeed = lengthdir_y(300, meleeAtkDirection + angleOffset);
			projectile.z = z;
			projectile.z_height = 24;
			projectile.zspeed = -10;
			projectile.zgravity = 300;
	}
	
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