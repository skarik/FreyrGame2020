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
else if (m_aiScript_requestCommand == kAiRequestCommand_Face)
{
	m_aiScript_requestCommand = null;
	aimotionFaceAt(m_aiScript_requestPositionX, m_aiScript_requestPositionY, -1);
}
else if (m_aiScript_requestCommand == kAiRequestCommand_Animation)
{
	m_aiScript_requestCommand = null;
	
	var sprite_target = null;
	if (m_aiScript_requestAnimation == "wakeup0")
	{
		sprite_target = sc_16x16char;
	}
	else if (m_aiScript_requestAnimation == "wakeup1")
	{
		sprite_target = sc_16x16char;
	}
	
	if (sprite_target != null)
	{
		moAnimationPlayback = true;
		moAnimationPlaybackLooped = m_aiScript_requestAnimationLoop;
		moAnimationPlaybackEndOnFinish = false;
		animationSpeed = m_aiScript_requestSpeed;
		sprite_index = sprite_target;
	}
	else
	{
		moAnimationPlayback = false;
	}
}

// do hidden code
isHidden = false;
if (position_meeting(x, y, ob_areaTallGrass)
	&& position_meeting(x - 7, y, ob_areaTallGrass) && position_meeting(x + 7, y, ob_areaTallGrass)
	&& position_meeting(x, y - 4, ob_areaTallGrass) && position_meeting(x, y + 4, ob_areaTallGrass))
{
	isHidden = true;
}