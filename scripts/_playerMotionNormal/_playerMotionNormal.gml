// Update checks
_playerMotionCommonChecks();

var l_canMove = canMove && !m_isDead && !m_isStunned && !isBusyInteracting && !m_usingInventory;

// Set up the move speed
var l_moveSpeed = kMoveSpeed;
if (inWater)
	l_moveSpeed *= kMoveSpeedWaterPercent;
if (isBlocking)
	l_moveSpeed *= kMoveSpeedBlockingPercent;
if (m_isHolding)
	l_moveSpeed *= kMoveSpeedCarryingPercent;

// Generate the target motion
var xspeedTarget = 0.0;
var yspeedTarget = 0.0;

// Begin moving!
if (l_canMove)
{
	xspeedTarget = xAxis.value * l_moveSpeed;
	yspeedTarget = yAxis.value * l_moveSpeed;
}
else
{
	xspeedTarget = 0.0;
	yspeedTarget = 0.0;
}

// Limit speed target
var totalSpeed = sqrt(sqr(xspeedTarget) + sqr(yspeedTarget));
xspeedTarget *= min(1.0, l_moveSpeed / totalSpeed);
yspeedTarget *= min(1.0, l_moveSpeed / totalSpeed);

// Select acceleration
var l_moveAcceleration = onGround ? kMoveAcceleration : kMoveAccelerationAir;
if (sqr(xspeedTarget) + sqr(yspeedTarget) < 0.01)
{
	l_moveAcceleration = onGround ? kMoveAccelerationStop : kMoveAccelerationAirStop;
}

// Accelerate up to the target
var accelerationDelta = l_moveAcceleration * Time.deltaTime;
var delta = 0.0;
delta = xspeedTarget - xspeed;
xspeed += (abs(delta) > accelerationDelta) ? (sign(delta) * accelerationDelta) : delta;
delta = yspeedTarget - yspeed;
yspeed += (abs(delta) > accelerationDelta) ? (sign(delta) * accelerationDelta) : delta;


// If motion is not stopped, check for some sliding angle stuff
if (sqr(xspeed) + sqr(yspeed) > 0)
{
	// If up ahread is a wall, see if we can rotate left or right
	var next_x = x + xspeed * Time.deltaTime;
	var next_y = y + yspeed * Time.deltaTime;
	//if (place_meeting(next_x, next_y, ob_collider))
	if (collision3_meeting(next_x, next_y, z, false))
	{
		//var motionAngle = point_direction(0, 0, xspeed, yspeed);
		// this could be simplified if we just use cross product to get perpendicular offsets
		var motionCrossX = -yspeed;
		var motionCrossY = xspeed;
		var motionCrossLen = sqrt(sqr(motionCrossX) + sqr(motionCrossY));
		motionCrossX /= motionCrossLen;
		motionCrossY /= motionCrossLen;
		
		var kMaxSidestep = sprite_get_width(sprite_exists(mask_index) ? mask_index : sprite_index) * 0.75;
		var kMaxSidestepMovestep = 0.5;
		
		for (var i = 0; i <= kMaxSidestep; i += kMaxSidestepMovestep)
		{
			//if (!place_meeting(next_x + motionCrossX * i, next_y + motionCrossY * i, ob_collider))
			if (!collision3_meeting(next_x + motionCrossX * i, next_y + motionCrossY * i, z, false))
			{
				x += motionCrossX * min(i, kMoveSpeed * Time.deltaTime);
				y += motionCrossY * min(i, kMoveSpeed * Time.deltaTime);
				xspeed *= 1.0 - abs(motionCrossX);
				yspeed *= 1.0 - abs(motionCrossY);
				break;
			}
			//if (!place_meeting(next_x - motionCrossX * i, next_y - motionCrossY * i, ob_collider))
			if (!collision3_meeting(next_x - motionCrossX * i, next_y - motionCrossY * i, z, false))
			{
				x -= motionCrossX * min(i, kMoveSpeed * Time.deltaTime);
				y -= motionCrossY * min(i, kMoveSpeed * Time.deltaTime);
				xspeed *= 1.0 - abs(motionCrossX);
				yspeed *= 1.0 - abs(motionCrossY);
				break;
			}
		}
	}
}

// Update the elevation if on the ground
if (onGround)
{
	if (place_meeting(x, y, ob_elevationBlendArea))
	{
		 z = collision3_get_highest_meeting(x, y, z);
	}
}
else
{
	var z_prev = z;
	
	// Get the floor z
	z = collision3_get_highest_meeting(x, y, z);
	
	// Add to the height if falling
	//if (z_prev > z)
	{
		y += z_prev - z;
		z_height += z_prev - z;
	}
	
	// Perform falling
	zspeed -= Time.deltaTime * 256.0;
	
	// Perform on-ground check
	if (z_height + zspeed * Time.deltaTime < 0)
	{
		zspeed = 0;
		z_height = 0;
		onGround = true;
	}
	
	// Perform the actual speed
	z_height += zspeed * Time.deltaTime;
}

// Check if jumping off the edge
if (onGround)
{
	// If motion is not stopped, check for some ledge jumping stuff
	if (sqr(xspeed) + sqr(yspeed) > 0)
	{
		// If up ahread is a wall, see if we can rotate left or right
		var next_x = x + xspeed * Time.deltaTime;
		var next_y = y + yspeed * Time.deltaTime;
		if (collision3_meeting(next_x, next_y, z, false))
		{
			if (!collision3_meeting(next_x, next_y, z, true))
			{
				onGround = false;
				z_height += 2;
				zspeed = 32.0;
			}
		}
	}
}


_playerMotionCommonCollision();

// Limit max speed
var totalSpeed = sqrt(sqr(xspeed) + sqr(yspeed));
xspeed *= min(1.0, l_moveSpeed / totalSpeed);
yspeed *= min(1.0, l_moveSpeed / totalSpeed);

// Finally move
x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;
