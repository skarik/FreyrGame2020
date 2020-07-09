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

// Move to face
facingDirection += median(-angleSpeed, +angleSpeed, angle_difference(targetDirection, facingDirection));

// Update the aiming to match the facing for now
aimingDirection = facingDirection;
aiming2Direction = facingDirection;