// @function aimotionFaceAt(direction, speed)
// @desc Turns the NPC to face at the given direction
// @param direction to face to
// @param speed	at which we change angle

// change
//aimingDirection
//facingDirection

var targetDirection = argument0;
var angleSpeed = argument1;

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