function aiscriptRequestMove(argument0, argument1, argument2, argument3, argument4) {
	var target = argument0;
	var style = argument1;
	var target_x = argument2;
	var target_y = argument3;
	var target_speed = argument4;

	with (target)
	{
		m_aiScript_requestStyle = style;
		m_aiScript_requestCommand = kAiRequestCommand_Move;
		m_aiScript_requestPositionX = target_x;
		m_aiScript_requestPositionY = target_y;
		m_aiScript_requestSpeed = target_speed;
	}

	// TODO: more complicated behaviors


}
