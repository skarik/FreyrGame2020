// @function aimotionFaceAt(x, y, speed)
// @param x	xpos to look at
// @param y	ypos to look at
// @param speed	at which we change angle

// change
//aimingDirection
//facingDirection

var targetX = argument0;
var targetY = argument1;
var angleSpeed = argument2;
var targetDirection = point_direction(x, y, targetX, targetY);

// Update speed for instant moving
if (angleSpeed < 0)
	angleSpeed = 360.0;
else
	angleSpeed *= Time.deltaTime;

// Change the direction to fix properly
if (abs(targetDirection - facingDirection) > 180)
{
	if (targetDirection > facingDirection)
		targetDirection -= 180;
	else
		targetDirection += 180;
}

// Move to face
if (abs(targetDirection - facingDirection) <= angleSpeed)
{
	facingDirection = targetDirection;
}
else
{
	facingDirection += sign(targetDirection - facingDirection) * angleSpeed;
}

// Update the aiming to match the facing for now
aimingDirection = facingDirection;