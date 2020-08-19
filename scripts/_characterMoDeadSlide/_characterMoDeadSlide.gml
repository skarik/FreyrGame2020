// Perform area checks
inWater = areaInWater(x, y, z + z_height);

// Set up the move speed
var l_moveSpeed = kMoveSpeed;
if (onGround)
	l_moveSpeed *= kMoveSpeedStunPercent;
else
	l_moveSpeed *= kMoveSpeedStunAirPercent;
	
// Select acceleration
var l_moveAcceleration = onGround ? kMoveAcceleration : kMoveAccelerationAir;
// Slow down when stunned
if (onGround)
	l_moveAcceleration = kMoveAccelerationStunned;
else
	l_moveAcceleration = kMoveAccelerationAirStunned;

// Accelerate up to the target
var accelerationDelta = l_moveAcceleration * Time.deltaTime;
var delta = 0.0;
delta = -xspeed;
xspeed += (abs(delta) > accelerationDelta) ? (sign(delta) * accelerationDelta) : delta;
delta = -yspeed;
yspeed += (abs(delta) > accelerationDelta) ? (sign(delta) * accelerationDelta) : delta;

// Update Z
_playerMotionCommonZUpdate();

// Collide with walls
_playerMotionCommonCollision();

// Limit max speed
var totalSpeed = sqrt(sqr(xspeed) + sqr(yspeed));
xspeed *= min(1.0, l_moveSpeed / totalSpeed);
yspeed *= min(1.0, l_moveSpeed / totalSpeed);

// Finally move
x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;
