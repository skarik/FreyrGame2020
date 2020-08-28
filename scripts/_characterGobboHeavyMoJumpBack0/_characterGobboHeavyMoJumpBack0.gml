var kMoveLength = 0.5;
var kDashMoveSpeed = kMoveSpeed * 1.5;
var kLandingPoint = 0.45;

// Increment timer
var prevMoveTimer = m_aiGobboHeavy_movetimer;
m_aiGobboHeavy_movetimer += Time.deltaTime;
var moveTimer = m_aiGobboHeavy_movetimer;

// Get percent, used for animation and behavior
var l_dashPercent = moveTimer / kMoveLength;

// Set animation state
isDashing = true;

// Set up the move direction
meleeAtkDirection = -facingDirection;

// Do checks & motion
var l_moveSpeedLandPoint = kLandingPoint / kMoveLength;
var l_moveSpeed = kDashMoveSpeed * (1.0 - saturate((l_dashPercent - l_moveSpeedLandPoint) / (1.0 - l_moveSpeedLandPoint)));
_playerMoCommonAttackPreMove(l_moveSpeed, false);

// Rise up & fall w/ the height target, but if falling dont override it
z_height = 8.0 * sin(min(1.0, l_dashPercent / l_moveSpeedLandPoint) * pi);

// Update Z
_playerMotionCommonZUpdate();

if (m_aiGobboHeavy_movetimer >= kMoveLength)
{
	moScriptOverride = null;
	isDashing = false;
	
	xspeed = 0.0; // Stop at end of dash
	yspeed = 0.0; 
}