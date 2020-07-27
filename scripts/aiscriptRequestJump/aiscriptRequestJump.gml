/// @function aiscriptRequestJump(target, style, target_x, target_y, target_speed)
/// @param target
/// @param style {kAiStyle}
/// @param target_x
/// @param target_y
/// @param target_speed {Real}
var target = argument0;
var style = argument1;
var target_x = argument2;
var target_y = argument3;
var target_speed = argument4;

with (target)
{
	m_aiScript_requestStyle = style;
	m_aiScript_requestCommand = kAiRequestCommand_Jump;
	m_aiScript_requestPositionX = target_x;
	m_aiScript_requestPositionY = target_y;
	m_aiScript_requestSpeed = target_speed;
	
	m_aiScript_jumpStartX = x;
	m_aiScript_jumpStartY = y;
	m_aiScript_jumpStartZ = z;
	m_aiScript_jumpTargetZ = collision3_get_highest_position(m_aiScript_requestPositionX, m_aiScript_requestPositionY, z);
	
	m_aiScript_jumpDistance = sqrt(sqr(m_aiScript_requestPositionX - x) + sqr(m_aiScript_requestPositionY - y) + sqr(m_aiScript_jumpTargetZ - z));
	m_aiScript_jumpTimer = 0.0;
}

// TODO: more complicated behaviors