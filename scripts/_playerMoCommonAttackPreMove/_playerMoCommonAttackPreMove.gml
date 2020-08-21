///@function _playerMoCommonAttackPreMove(inSpeed, isPercent)
///@param inSpeed
///@param isPercent

var inSpeed = argument0;
var isPercent = argument1;

// Update checks
if (kIsDetailedCharacter)
{
	_playerMotionCommonChecks();
}
else
{
	inWater = areaInWater(x, y, z);
}

// Set up the move speed
var l_moveSpeed = isPercent ? kMoveSpeed : inSpeed;
if (inWater)
	l_moveSpeed *= kMoveSpeedWaterPercent;
if (isBlocking)
	l_moveSpeed *= kMoveSpeedBlockingPercent;
if (m_isHolding)
	l_moveSpeed *= kMoveSpeedCarryingPercent;

// Apply input speed
if (isPercent)
	l_moveSpeed *= inSpeed;

// Move the player...
xspeed = lengthdir_x(l_moveSpeed, meleeAtkDirection);
yspeed = lengthdir_y(l_moveSpeed, meleeAtkDirection);

_playerMotionCommonCollision();

// Finally move
x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;