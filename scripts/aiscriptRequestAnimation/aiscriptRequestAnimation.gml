var target = argument0;
var style = argument1;
var animation = argument2;
var loop = argument3;
var target_speed = argument4;

with (target)
{
	m_aiScript_requestStyle = style;
	m_aiScript_requestCommand = kAiRequestCommand_Animation;
	m_aiScript_requestAnimation = animation;
	m_aiScript_requestAnimationLoop = loop;
	m_aiScript_requestSpeed = target_speed;
}

// TODO: more complicated behaviors