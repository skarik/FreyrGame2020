var target = argument0;
var style = argument1;

with (target)
{
	m_aiScript_requestStyle = style;
	m_aiScript_requestCommand = kAiRequestCommand_Stop;
}

// TODO: more complicated behaviors