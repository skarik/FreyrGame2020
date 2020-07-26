/// @description Create the Goto

var callee = id;
/*with (m_cutsceneTarget)
{
	cutsceneJumpToLabel(callee.m_cutsceneLabel);
}*/
/*with (m_aiTarget)
{
	// GO, AI, GO!!!
	
}*/
if (m_teleportToStart)
{
	m_aiTarget.x = m_aiTargetPathnode.x;
	m_aiTarget.y = m_aiTargetPathnode.y;
}
aiscriptRequestFollowPath(m_aiTarget, kAiStyle_Scripted, m_aiTargetPathnode, 1.0);