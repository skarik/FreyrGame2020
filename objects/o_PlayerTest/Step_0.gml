// update input
controlUpdate(false);

// Move the player
playerMotionStep();

// update camera
var aimerDistance = min(48.0,
						point_distance(o_PlayerTest.x, o_PlayerTest.y,
									   o_PlayerTest.uPosition, o_PlayerTest.vPosition)
						);
camPlayerUpdate(
	x + lengthdir_x(aimerDistance, aimingDirection),
	y + lengthdir_y(aimerDistance, aimingDirection),
	xspeed,
	yspeed);