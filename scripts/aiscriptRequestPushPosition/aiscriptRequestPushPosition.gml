function aiscriptRequestPushPosition(argument0, argument1, argument2) {
	var target = argument0;
	var tx = argument1;
	var ty = argument2;

	with (target)
	{
		m_aiScript_requestPositionX = tx;
		m_aiScript_requestPositionY = ty;
	}


}
