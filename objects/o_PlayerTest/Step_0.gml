// update input
controlUpdate(false);

// Move the player
playerMotionStep();

// update camera
var aimerDistance = min(48.0,
						point_distance(o_PlayerTest.x, o_PlayerTest.y,
									   o_PlayerTest.uPosition, o_PlayerTest.vPosition)
						);
// fuck the aimer for now:
aimerDistance = 2.0;

var pl = id;
with (camera)
{
	camPlayerUpdate(
		round(round(pl.x) + lengthdir_x(aimerDistance, pl.aimingDirection)),
		round(round(pl.y) + lengthdir_y(aimerDistance, pl.aimingDirection) - pl.z_height),
		pl.xspeed,
		pl.yspeed);
}
view_update_audio();


// HACK: apply certain cutscene commands
if (m_aiScript_requestCommand == kAiRequestCommand_Teleport)
{
	m_aiScript_requestCommand = null;
	x = m_aiScript_requestPositionX;
	y = m_aiScript_requestPositionY;
	z_ready = false;
}