/// @function aimotionFaceAt(x, y, speed)
/// @desc Turns the NPC to face at the given direction
/// @param x	xpos to look at
/// @param y	ypos to look at
/// @param speed	at which we change angle

// change
//aimingDirection
//facingDirection

var targetX = argument0;
var targetY = argument1;
var angleSpeed = argument2;
var targetDirection = point_direction(x, y, targetX, targetY);

aimotionFaceAtDirection(targetDirection, angleSpeed);