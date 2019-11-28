var target = argument0;
var style = argument1;
var target_x = argument2;
var target_y = argument3;

with (target)
{
	m_aiScript_requestStyle = style;
	m_aiScript_requestCommand = kAiRequestCommand_Face;
	m_aiScript_requestPositionX = target_x;
	m_aiScript_requestPositionY = target_y;
}

// TODO: more complicated behaviors