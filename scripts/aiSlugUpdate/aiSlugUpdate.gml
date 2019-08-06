
// Find target
m_aiTarget = getPlayer();


if (m_aiState == 0)
{
	if (m_aiWanderTimer < 0.0)
	{
		var wander_dir = choose(0, 90, 180, 270);
		m_aiWander = [lengthdir_x(1.0, wander_dir), lengthdir_y(1.0, wander_dir)];
		
		m_aiWanderTimer = 0.0;
	}
	
	// Move around
	//aimotionMoveTo(x, y, 1.0);
	aimotionMoveAt(m_aiWander[0], m_aiWander[1], 1.0);
	
	// Only wander for N time or stop on walls
	m_aiWanderTimer += Time.deltaTime;
	
	if (m_aiWanderTimer > 3.0 || moHitWall)
	{
		aimotionMoveAt(0, 0, 0);
		
		// Stop or move somewhere else.
		m_aiState = 1;
		m_aiWanderTimer = 0.0;
	}
}
// Standing around, begin new motion soon
if (m_aiState == 1)
{
	// We want to float around and do nothing for now
	m_aiWanderTimer += Time.deltaTime * 2.0;
	if (m_aiWanderTimer > 1.0)
	{
		// Mark motion as has to be redone, and keep moving
		m_aiWanderTimer = -1.0;
		m_aiState = 0;
	}
	
	// If the target is nearby, go to attacking
	if (sqr(x - m_aiTarget.x) + sqr(y - m_aiTarget.y) < sqr(80))
	{
		m_aiAttackTimer = 0.0;
		m_aiState = 2;
	}
}
// Time to do attacking
if (m_aiState == 2)
{
	// Charge the attack
	m_aiAttackTimer += Time.deltaTime;
	
	// If stunned, reset timer
	if (isStunned)
	{
		m_aiAttackTimer = min(0.5, m_aiAttackTimer);
	}
	
	// At the end, attack
	if (m_aiAttackTimer > 1.0)
	{
		// Reset timer
		m_aiAttackTimer = 0.0;
		
		// Attack
		aiSlugShockwaveAttack();
		
		// Mark motion as has to be redone, and keep moving
		m_aiWanderTimer = -1.0;
		m_aiState = 0;
	}
}