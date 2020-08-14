// Use the timer to move to the target

var kTargetSpeed = (kDashDistance / kDashTime) * 2.0;

if (Time.deltaTime > 0.0)
{
	m_perfectCounterTimer += Time.unscaled_dt;
	
	// Move the player to the target
	var t_dir = point_direction(x, y, m_perfectCounterTarget.x, m_perfectCounterTarget.y);

	xspeed = lengthdir_x(kTargetSpeed * Time.unscaled_dt, t_dir) / Time.deltaTime;
	yspeed = lengthdir_y(kTargetSpeed * Time.unscaled_dt, t_dir) / Time.deltaTime;

	// update facing & override shit for now
	facingDirection = t_dir;
	aimingDirection = t_dir;
	meleeAtkDirection = t_dir;

	_playerMotionCommonCollision();
	
	x += xspeed * Time.deltaTime;
	y += yspeed * Time.deltaTime;
	
	// If at the enemy, kick some ass.
	if (place_meeting(x + xspeed * Time.deltaTime, y + yspeed * Time.deltaTime, m_perfectCounterTarget))
	{
		moScriptOverride = _playerMoAttackCounterHit;
		// Set up attach variables
		meleeAtkCurrent = 0;
		// do the thing
		meleeAtkTimer = 0.0;
		isAttacking = true;
		isDashing = false;
		meleeAtkDirection = t_dir;
		
		// Resume time
		m_perfectCounterFreezer.m_fadeIn = false;
		m_perfectCounterFreezer = null;
	}
	
	// If taking too long to get there, let's ease off a bunch.
	if (m_perfectCounterTimer >= 1.0)
	{
		// Resume time
		m_perfectCounterFreezer.m_fadeIn = false;
		m_perfectCounterFreezer = null;
		moScriptOverride = null;
		
		// Kill focuser
		if (iexists(m_perfectCounterFocuser))
		{
			m_perfectCounterFocuser.m_cancelled = true;
			m_perfectCounterFocuser = null;
		}
	}
}