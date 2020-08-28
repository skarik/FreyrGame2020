var kMoveLength = 1.1;
var kStompTime = 5/10 * kMoveLength;
var kWallTime = 6/10 * kMoveLength;


// Increment timer
var prevMoveTimer = m_aiGobboHeavy_movetimer;
m_aiGobboHeavy_movetimer += Time.deltaTime;
var moveTimer = m_aiGobboHeavy_movetimer;

// Set animation state
isAttacking = true;

// Do checks & motion
_playerMoCommonAttackPreMove(0.0, false);

// Do FX
if (prevMoveTimer < kStompTime && moveTimer >= kStompTime)
{
	effectOnGroundHit(x, y);
}

// Create wall
if (prevMoveTimer < kWallTime && moveTimer >= kWallTime)
{
	if (array_length_1d(m_colliders) == 0)
	{
		// Find nearest ai walls
		var wallList = ds_list_create();
		var wallListCount = collision_circle_list(x, y, 300, o_aiWallHint, false, true, wallList, false);
		for (var i = 0; i < wallListCount; ++i)
		{
			var hint = wallList[|i];
		
			// New rock wall at the ai wall hint
			var newWall = inew(o_livelyRockWall);
				newWall.x = hint.x;
				newWall.y = hint.y;
				newWall.image_xscale = hint.image_xscale;
				newWall.image_yscale = hint.image_yscale;
				newWall.image_angle = hint.image_angle;
			
			// Save them, so we can destroy them later
			m_colliders[array_length_1d(m_colliders)] = newWall;
		}
		ds_list_destroy(wallList);
	}
}

// update animation
sprite_index = kAnimFightStomp;
animationIndex = floor((image_number - 0.01) * saturate(moveTimer / kMoveLength));
moAnimationPlayback = true;

// End case
if (prevMoveTimer < kMoveLength && moveTimer >= kMoveLength)
{
	moScriptOverride = null;
	moAnimationPlayback = false;
	isAttacking = false;
}