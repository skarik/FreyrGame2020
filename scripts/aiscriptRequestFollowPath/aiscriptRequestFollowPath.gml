/// @function aiscriptRequestFollowPath(target, style, target_pathnode, target_speed)
/// @param target
/// @param style {kAiStyle}
/// @param target_pathnode
/// @param target_speed {Real}
function aiscriptRequestFollowPath(argument0, argument1, argument2, argument3) {
	var target = argument0;
	var style = argument1;
	var target_pathnode = argument2;
	var target_speed = argument3;

	with (target)
	{
		m_aiScript_requestStyle = style;
		m_aiScript_requestCommand = kAiRequestCommand_FollowPath;
		m_aiScript_requestPathnode = target_pathnode;
		m_aiScript_requestSpeed = target_speed;
	}

	// TODO: more complicated behaviors


}
